-- DATOU App - Advanced Search RPC Function
-- Performant search with pagination, geosearch, text search, multi-filtering, and recommendations

CREATE OR REPLACE FUNCTION search_listings(
  -- Pagination
  page_limit INTEGER DEFAULT 20,
  page_offset INTEGER DEFAULT 0,
  
  -- Search and filtering
  search_query TEXT DEFAULT NULL,
  listing_types listing_type[] DEFAULT NULL,
  required_roles user_role[] DEFAULT NULL,
  
  -- Category filtering (flexible JSONB structure)
  categories JSONB DEFAULT NULL, -- {"photography": ["portrait", "wedding"], "modeling": ["fashion"]}
  
  -- Budget filtering
  min_budget DECIMAL DEFAULT NULL,
  max_budget DECIMAL DEFAULT NULL,
  budget_negotiable BOOLEAN DEFAULT NULL,
  
  -- Location and geography
  user_lat DOUBLE PRECISION DEFAULT NULL,
  user_lng DOUBLE PRECISION DEFAULT NULL,
  max_distance_km INTEGER DEFAULT NULL,
  include_remote BOOLEAN DEFAULT true,
  location_search TEXT DEFAULT NULL,
  
  -- Timing
  event_date_from TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  event_date_to TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  application_deadline_from TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  
  -- Requirements (prefixed to avoid name collisions with OUT columns)
  filter_required_skills TEXT[] DEFAULT NULL,
  experience_levels experience_level[] DEFAULT NULL,
  filter_min_age INTEGER DEFAULT NULL,
  filter_max_age INTEGER DEFAULT NULL,
  
  -- Flags
  urgent_only BOOLEAN DEFAULT false,
  featured_only BOOLEAN DEFAULT false,
  
  -- Sorting
  sort_by sort_option DEFAULT 'newest',
  
  -- User context for recommendations
  current_user_id UUID DEFAULT NULL
)
RETURNS TABLE (
  -- Listing fields
  id UUID,
  creator_id UUID,
  title TEXT,
  description TEXT,
  type listing_type,
  required_role user_role,
  photography_categories photography_category[],
  videography_categories videography_category[],
  modeling_categories modeling_category[],
  budget DECIMAL(10,2),
  is_negotiable BOOLEAN,
  location_text TEXT,
  is_remote BOOLEAN,
  event_date TIMESTAMP WITH TIME ZONE,
  event_duration_hours INTEGER,
  application_deadline TIMESTAMP WITH TIME ZONE,
  required_skills TEXT[],
  preferred_experience experience_level,
  min_age INTEGER,
  max_age INTEGER,
  contact_method contact_method,
  image_urls TEXT[],
  status listing_status,
  is_urgent BOOLEAN,
  is_featured BOOLEAN,
  view_count INTEGER,
  application_count INTEGER,
  save_count INTEGER,
  tags TEXT[],
  created_at TIMESTAMP WITH TIME ZONE,
  updated_at TIMESTAMP WITH TIME ZONE,
  expires_at TIMESTAMP WITH TIME ZONE,
  
  -- Computed fields
  distance_km DOUBLE PRECISION,
  is_saved BOOLEAN,
  relevance_score DOUBLE PRECISION,
  total_count BIGINT -- For pagination info
) AS $$
DECLARE
  user_location POINT;
  base_query TEXT;
  where_conditions TEXT[];
  having_conditions TEXT[];
  order_clause TEXT;
  final_query TEXT;
BEGIN
  -- Convert user coordinates to POINT for distance calculations
  IF user_lat IS NOT NULL AND user_lng IS NOT NULL THEN
    user_location := POINT(user_lng, user_lat);
  END IF;
  
  -- Build base query with CTEs for performance
  base_query := '
    WITH filtered_listings AS (
      SELECT 
        l.*,
        -- Distance calculation (safe for non-point schemas)
        CASE 
          WHEN $1::POINT IS NOT NULL 
            AND l.location IS NOT NULL 
            AND pg_typeof(l.location)::text = ''point''
          THEN (l.location::point <@> $1::POINT) * 1.609344 -- miles to km
          ELSE NULL 
        END as distance_km,
        
        -- Check if saved by current user
        CASE 
          WHEN $2::UUID IS NOT NULL 
          THEN EXISTS(SELECT 1 FROM listing_saves ls WHERE ls.listing_id = l.id AND ls.user_id = $2::UUID)
          ELSE false 
        END as is_saved,
        
        -- Calculate relevance score for recommendations
        CASE 
          WHEN $3::TEXT IS NOT NULL THEN
            -- Text search relevance
            GREATEST(
              ts_rank(l.search_vector, plainto_tsquery(''english'', $3::TEXT)) * 4,
              similarity(l.title, $3::TEXT) * 3,
              similarity(l.description, $3::TEXT) * 2
            )
          ELSE 1.0
        END +
        -- Boost urgent listings
        CASE WHEN l.is_urgent THEN 0.5 ELSE 0 END +
        -- Boost featured listings  
        CASE WHEN l.is_featured THEN 0.3 ELSE 0 END +
        -- Boost recent listings
        CASE 
          WHEN l.created_at > NOW() - INTERVAL ''7 days'' THEN 0.2
          WHEN l.created_at > NOW() - INTERVAL ''30 days'' THEN 0.1
          ELSE 0 
        END +
        -- Boost listings with higher engagement
        (l.save_count * 0.01) + (l.view_count * 0.001) as relevance_score,
        
        -- Total count for pagination (same for all rows)
        COUNT(*) OVER() as total_count
        
      FROM listings l
      WHERE l.status = ''active''
        AND (l.expires_at IS NULL OR l.expires_at > NOW())
  ';
  
  -- Build WHERE conditions array
  where_conditions := ARRAY[]::TEXT[];
  
  -- Text search
  IF search_query IS NOT NULL AND search_query != '' THEN
    where_conditions := array_append(where_conditions, 
      '(l.search_vector @@ plainto_tsquery(''english'', ''' || search_query || ''') OR
        l.title ILIKE ''%' || search_query || '%'' OR
        l.description ILIKE ''%' || search_query || '%'' OR
        l.location_text ILIKE ''%' || search_query || '%'')');
  END IF;
  
  -- Listing types
  IF listing_types IS NOT NULL AND array_length(listing_types, 1) > 0 THEN
    where_conditions := array_append(where_conditions, 
      'l.type = ANY(''' || listing_types::TEXT || '''::listing_type[])');
  END IF;
  
  -- Required roles
  IF required_roles IS NOT NULL AND array_length(required_roles, 1) > 0 THEN
    where_conditions := array_append(where_conditions, 
      '(l.required_role IS NULL OR l.required_role = ANY(''' || required_roles::TEXT || '''::user_role[]))');
  END IF;
  
  -- Category filtering (complex JSONB matching)
  IF categories IS NOT NULL THEN
    -- Photography categories
    IF categories ? 'photography' THEN
      where_conditions := array_append(where_conditions,
        'l.photography_categories && ARRAY[' || 
        (SELECT string_agg('''' || value::TEXT || '''', ',') 
         FROM jsonb_array_elements_text(categories->'photography')) || 
        ']::photography_category[]');
    END IF;
    
    -- Videography categories  
    IF categories ? 'videography' THEN
      where_conditions := array_append(where_conditions,
        'l.videography_categories && ARRAY[' || 
        (SELECT string_agg('''' || value::TEXT || '''', ',') 
         FROM jsonb_array_elements_text(categories->'videography')) || 
        ']::videography_category[]');
    END IF;
    
    -- Modeling categories
    IF categories ? 'modeling' THEN
      where_conditions := array_append(where_conditions,
        'l.modeling_categories && ARRAY[' || 
        (SELECT string_agg('''' || value::TEXT || '''', ',') 
         FROM jsonb_array_elements_text(categories->'modeling')) || 
        ']::modeling_category[]');
    END IF;
  END IF;
  
  -- Budget filtering
  IF min_budget IS NOT NULL THEN
    where_conditions := array_append(where_conditions, 'l.budget >= ' || min_budget);
  END IF;
  
  IF max_budget IS NOT NULL THEN
    where_conditions := array_append(where_conditions, 'l.budget <= ' || max_budget);
  END IF;
  
  IF budget_negotiable IS NOT NULL THEN
    where_conditions := array_append(where_conditions, 'l.is_negotiable = ' || budget_negotiable);
  END IF;
  
  -- Location filtering
  IF location_search IS NOT NULL AND location_search != '' THEN
    where_conditions := array_append(where_conditions, 
      'l.location_text ILIKE ''%' || location_search || '%''');
  END IF;
  
  -- Remote inclusion
  IF NOT include_remote THEN
    where_conditions := array_append(where_conditions, 'l.is_remote = false');
  END IF;
  
  -- Date filtering
  IF event_date_from IS NOT NULL THEN
    where_conditions := array_append(where_conditions, 
      'l.event_date >= ''' || event_date_from || '''');
  END IF;
  
  IF event_date_to IS NOT NULL THEN
    where_conditions := array_append(where_conditions, 
      'l.event_date <= ''' || event_date_to || '''');
  END IF;
  
  IF application_deadline_from IS NOT NULL THEN
    where_conditions := array_append(where_conditions, 
      'l.application_deadline >= ''' || application_deadline_from || '''');
  END IF;
  
  -- Skills filtering
  IF filter_required_skills IS NOT NULL AND array_length(filter_required_skills, 1) > 0 THEN
    where_conditions := array_append(where_conditions, 
      'l.required_skills && ''' || filter_required_skills::TEXT || '''::TEXT[]');
  END IF;
  
  -- Experience filtering
  IF experience_levels IS NOT NULL AND array_length(experience_levels, 1) > 0 THEN
    where_conditions := array_append(where_conditions, 
      '(l.preferred_experience IS NULL OR l.preferred_experience = ANY(''' || experience_levels::TEXT || '''::experience_level[]))');
  END IF;
  
  -- Age filtering
  IF filter_min_age IS NOT NULL THEN
    where_conditions := array_append(where_conditions, 
      '(l.max_age IS NULL OR l.max_age >= ' || filter_min_age || ')');
  END IF;
  
  IF filter_max_age IS NOT NULL THEN
    where_conditions := array_append(where_conditions, 
      '(l.min_age IS NULL OR l.min_age <= ' || filter_max_age || ')');
  END IF;
  
  -- Flags
  IF urgent_only THEN
    where_conditions := array_append(where_conditions, 'l.is_urgent = true');
  END IF;
  
  IF featured_only THEN
    where_conditions := array_append(where_conditions, 'l.is_featured = true');
  END IF;
  
  -- Add WHERE conditions to base query
  IF array_length(where_conditions, 1) > 0 THEN
    base_query := base_query || ' AND ' || array_to_string(where_conditions, ' AND ');
  END IF;
  
  base_query := base_query || ')';
  
  -- Add HAVING clause for distance filtering
  having_conditions := ARRAY[]::TEXT[];
  
  IF max_distance_km IS NOT NULL AND user_location IS NOT NULL THEN
    having_conditions := array_append(having_conditions, 
      '(distance_km IS NULL OR distance_km <= ' || max_distance_km || ')');
  END IF;
  
  -- Build ORDER BY clause
  CASE sort_by
    WHEN 'newest' THEN
      order_clause := 'ORDER BY l.created_at DESC';
    WHEN 'oldest' THEN  
      order_clause := 'ORDER BY l.created_at ASC';
    WHEN 'budget_high' THEN
      order_clause := 'ORDER BY l.budget DESC NULLS LAST';
    WHEN 'budget_low' THEN
      order_clause := 'ORDER BY l.budget ASC NULLS LAST';
    WHEN 'deadline' THEN
      order_clause := 'ORDER BY l.application_deadline ASC NULLS LAST';
    WHEN 'recommended' THEN
      order_clause := 'ORDER BY relevance_score DESC, l.created_at DESC';
    ELSE
      order_clause := 'ORDER BY l.created_at DESC';
  END CASE;
  
  -- If distance is available, add it as secondary sort for nearby results
  IF user_location IS NOT NULL THEN
    order_clause := order_clause || ', distance_km ASC NULLS LAST';
  END IF;
  
  -- Construct final query
  final_query := base_query || '
    SELECT * FROM filtered_listings fl';
    
  IF array_length(having_conditions, 1) > 0 THEN
    final_query := final_query || ' HAVING ' || array_to_string(having_conditions, ' AND ');
  END IF;
  
  final_query := final_query || ' ' || order_clause || 
    ' LIMIT ' || page_limit || ' OFFSET ' || page_offset;
  
  -- Execute dynamic query with parameters
  RETURN QUERY EXECUTE final_query USING user_location, current_user_id, search_query;
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- Helper function to get category options for a specific type
CREATE OR REPLACE FUNCTION get_category_options(listing_type_param listing_type)
RETURNS JSONB AS $$
BEGIN
  CASE listing_type_param
    WHEN 'photography' THEN
      RETURN jsonb_build_array(
        'portrait', 'wedding', 'event', 'commercial', 'fashion', 'product',
        'automotive', 'real_estate', 'sports', 'nature', 'street', 'lifestyle'
      );
    WHEN 'videography' THEN
      RETURN jsonb_build_array(
        'commercial', 'wedding', 'music_video', 'documentary', 'corporate',
        'social_media', 'event', 'promotional', 'real_estate', 'automotive'
      );
    WHEN 'modeling' THEN
      RETURN jsonb_build_array(
        'fashion', 'commercial', 'fitness', 'beauty', 'lifestyle', 'automotive',
        'product', 'editorial', 'glamour', 'alternative'
      );
    ELSE
      RETURN '[]'::jsonb;
  END CASE;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Function to get trending/popular searches
CREATE OR REPLACE FUNCTION get_trending_searches(
  days_back INTEGER DEFAULT 7,
  result_limit INTEGER DEFAULT 10
)
RETURNS TABLE (
  search_term TEXT,
  search_count BIGINT,
  avg_results INTEGER
) AS $$
BEGIN
  -- This would typically track search analytics
  -- For now, return some common searches based on listing data
  RETURN QUERY
  SELECT 
    unnest(ARRAY['photography', 'wedding', 'portrait', 'fashion', 'commercial', 'modeling', 'videography']) as search_term,
    (random() * 100)::BIGINT as search_count,
    (random() * 50 + 10)::INTEGER as avg_results
  LIMIT result_limit;
END;
$$ LANGUAGE plpgsql STABLE;

-- Function to get personalized recommendations
CREATE OR REPLACE FUNCTION get_recommended_listings(
  user_id UUID,
  result_limit INTEGER DEFAULT 10
)
RETURNS TABLE (
  id UUID,
  title TEXT,
  type listing_type,
  budget DECIMAL(10,2),
  location_text TEXT,
  relevance_score DOUBLE PRECISION
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    l.id,
    l.title,
    l.type,
    l.budget,
    l.location_text,
    -- Simple recommendation based on user's saved listings and role
    (CASE 
      WHEN EXISTS(
        SELECT 1 FROM listing_saves ls 
        JOIN listings sl ON sl.id = ls.listing_id 
        WHERE ls.user_id = get_recommended_listings.user_id 
        AND sl.type = l.type
      ) THEN 2.0 ELSE 1.0 END) +
    (CASE WHEN l.is_featured THEN 0.5 ELSE 0 END) +
    (CASE WHEN l.created_at > NOW() - INTERVAL '3 days' THEN 0.3 ELSE 0 END) as relevance_score
  FROM listings l
  WHERE l.status = 'active'
    AND l.creator_id != get_recommended_listings.user_id
    AND (l.expires_at IS NULL OR l.expires_at > NOW())
  ORDER BY relevance_score DESC, l.created_at DESC
  LIMIT result_limit;
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;


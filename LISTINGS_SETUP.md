# DATOU App - Listings Feature Setup Guide

This guide provides complete setup instructions for the advanced listings feature with Supabase backend.

## 🏗️ Architecture Overview

### Backend (Supabase)
- **PostgreSQL Database** with advanced indexing and full-text search
- **RLS (Row Level Security)** for data protection
- **Custom RPC Functions** for performant search with pagination, geosearch, and filtering
- **Extensions**: `pg_trgm` (fuzzy search), `cube` + `earthdistance` (geospatial), `uuid-ossp`

### Frontend (Flutter)
- **Advanced UI** with role chips, category filters, search, sort, and view toggles
- **Infinite Scroll** with optimistic loading
- **Geolocation Integration** for distance-based search
- **Favorites/Saved** functionality with real-time updates
- **State Management** with Riverpod and Hooks

## 🚀 Setup Instructions

### 1. Database Setup

Execute the SQL files in your Supabase SQL Editor:

1. **First, run the schema setup:**
```sql
-- Copy and paste the entire content of supabase_schema.sql
```

2. **Then, add the search RPC functions:**
```sql
-- Copy and paste the entire content of supabase_search_rpc.sql
```

### 2. Flutter Dependencies

The required dependencies are already added to `pubspec.yaml`:

```yaml
dependencies:
  hooks_riverpod: ^2.6.1
  flutter_hooks: ^0.20.5
  supabase_flutter: ^2.3.2
  geolocator: ^10.1.0
  # ... other existing dependencies
```

Run:
```bash
cd datou_app
flutter pub get
```

### 3. Generate Model Files

Since we updated the listing models, regenerate the Freezed/JSON serialization files:

```bash
cd datou_app
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 4. Platform Permissions

#### iOS (ios/Runner/Info.plist)
Add location permissions:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show nearby listings and calculate distances.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs location access to show nearby listings and calculate distances.</string>
```

#### Android (android/app/src/main/AndroidManifest.xml)
Add location permissions:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

## 📊 Database Schema Details

### Core Tables

#### `listings`
- **Primary fields**: title, description, type, budget, location
- **Categories**: Dynamic arrays for photography/videography/modeling categories
- **Geospatial**: `location` POINT field for distance calculations
- **Search**: `search_vector` TSVECTOR for full-text search
- **Analytics**: view_count, save_count, application_count

#### `listing_saves`
- **Purpose**: Track user favorites/saved listings
- **Relations**: user_id → users, listing_id → listings
- **Constraints**: Unique constraint prevents duplicate saves

#### `user_preferences`
- **Purpose**: Store user preferences for recommendations
- **Flexible**: JSONB categories field for different listing types

### Indexes for Performance

```sql
-- Geospatial index for location-based searches
CREATE INDEX idx_listings_location ON listings USING GIST(location);

-- Full-text search indexes
CREATE INDEX idx_listings_search_vector ON listings USING GIN(search_vector);
CREATE INDEX idx_listings_title_trgm ON listings USING GIN(title gin_trgm_ops);

-- Array indexes for categories
CREATE INDEX idx_listings_photography_categories ON listings USING GIN(photography_categories);
-- ... more category indexes
```

## 🔍 Search RPC Function

### `search_listings()` Parameters

```sql
search_listings(
  -- Pagination
  page_limit INTEGER DEFAULT 20,
  page_offset INTEGER DEFAULT 0,
  
  -- Search and filtering
  search_query TEXT DEFAULT NULL,
  listing_types listing_type[] DEFAULT NULL,
  categories JSONB DEFAULT NULL,
  
  -- Budget filtering
  min_budget DECIMAL DEFAULT NULL,
  max_budget DECIMAL DEFAULT NULL,
  
  -- Location and geography
  user_lat DOUBLE PRECISION DEFAULT NULL,
  user_lng DOUBLE PRECISION DEFAULT NULL,
  max_distance_km INTEGER DEFAULT NULL,
  
  -- Sorting
  sort_by sort_option DEFAULT 'newest',
  
  -- User context
  current_user_id UUID DEFAULT NULL
)
```

### Advanced Features

1. **Fuzzy Text Search**: Uses `pg_trgm` for typo-tolerant search
2. **Geospatial Search**: Calculates distances using `earthdistance`
3. **Multi-category Filtering**: JSONB structure for flexible category matching
4. **Relevance Scoring**: Combines text relevance, recency, urgency, and engagement
5. **Optimized Pagination**: Returns total count for proper pagination UI

## 🎨 UI Features

### Header Actions
- **Search Toggle**: Expandable search bar with real-time filtering
- **Filter Button**: Toggle advanced filters panel

### Role Chips
- **All, Photography, Video, Modeling, Casting**
- **Dynamic Categories**: Secondary chips change based on selected role
- **Multi-select**: Categories within a role type

### Sort & View Toggle
- **Sort Options**: Newest, Oldest, Budget (High/Low), Deadline, Recommended
- **View Modes**: List view (implemented), Map view (placeholder)

### Advanced Filters
- **Budget Range**: Min/max budget inputs
- **Quick Toggles**: Urgent only, Remote OK
- **Future**: Date ranges, experience levels, skills

### Listing Cards
- **Enhanced Design**: Type badges, urgency indicators, distance display
- **Save Functionality**: Bookmark icon with real-time toggle
- **Rich Info**: Location, date, budget, engagement stats
- **Responsive**: Optimized for mobile with proper touch targets

## 🔄 State Management

### Providers
- `listingsProvider`: Main listings data with search results
- `listingsFiltersProvider`: Current filter state
- `savedListingsProvider`: User's saved/favorited listings
- `categoryOptionsProvider`: Dynamic category options per type
- `recommendedListingsProvider`: Personalized recommendations

### Key Features
- **Optimistic Updates**: UI updates immediately for saves/favorites
- **Infinite Scroll**: Automatic loading with proper loading states
- **Real-time Filters**: Instant search and filter application
- **Location Integration**: Automatic location detection with permissions

## 🧪 Testing the Implementation

### 1. Sample Data
Create some test listings in your Supabase dashboard:

```sql
INSERT INTO listings (
  creator_id, title, description, type, location_text, 
  location, budget, is_negotiable, photography_categories,
  status, created_at
) VALUES (
  'your-user-id-here',
  'Wedding Photography - Downtown Seattle',
  'Looking for an experienced wedding photographer for outdoor ceremony and reception.',
  'photography',
  'Seattle, WA',
  POINT(-122.3321, 47.6062), -- Seattle coordinates
  2500.00,
  true,
  ARRAY['wedding', 'portrait']::photography_category[],
  'active',
  NOW()
);
```

### 2. Test Search Features
- **Text Search**: Search for "wedding", "photography", "Seattle"
- **Category Filtering**: Select Photography → Wedding
- **Location Search**: Enable location permissions to see distance
- **Sorting**: Try different sort options
- **Favorites**: Save/unsave listings

### 3. Performance Testing
- **Large Dataset**: Add 1000+ listings to test pagination
- **Complex Queries**: Combine multiple filters
- **Geospatial**: Test with various user locations

## 🚀 FlutterFlow Integration

### RPC Calls in FlutterFlow

1. **Create Custom Action** for `searchListings`:
```dart
Future<List<dynamic>> searchListings({
  required int pageLimit,
  required int pageOffset,
  String? searchQuery,
  List<String>? listingTypes,
  // ... other parameters
}) async {
  final response = await SupaFlow.client.rpc('search_listings', params: {
    'page_limit': pageLimit,
    'page_offset': pageOffset,
    'search_query': searchQuery,
    'listing_types': listingTypes,
    // ... other parameters
  });
  
  return response as List<dynamic>;
}
```

2. **Create Custom Action** for `toggleSave`:
```dart
Future<bool> toggleListingSave(String listingId) async {
  final response = await SupaFlow.client.rpc('toggle_listing_save', params: {
    'listing_id': listingId,
  });
  
  return response as bool;
}
```

### Custom Widgets
- Import the `ListingsScreen` widget into FlutterFlow
- Configure as a custom widget with proper parameters
- Set up navigation and state management

## 📈 Performance Optimizations

### Database Level
- **Composite Indexes**: Optimized for common query patterns
- **Partial Indexes**: Only index active listings where needed
- **VACUUM and ANALYZE**: Regular maintenance for optimal performance

### Application Level
- **Pagination**: Efficient offset-based pagination with total counts
- **Caching**: Repository-level caching for category options
- **Debouncing**: Search input debouncing to reduce API calls
- **Optimistic Updates**: Immediate UI feedback for user actions

## 🔒 Security Features

### Row Level Security (RLS)
- **Public Listings**: Anyone can view active listings
- **Owner Access**: Users can only modify their own listings
- **Saved Listings**: Users can only access their own saves

### Data Validation
- **Enum Constraints**: Type-safe enums for categories and statuses
- **Check Constraints**: Budget validation, age range validation
- **Foreign Key Constraints**: Data integrity across tables

## 🎯 Future Enhancements

### Immediate (Next Sprint)
- **Map View**: Integrate Google Maps/Apple Maps
- **Push Notifications**: New listings matching user preferences
- **Advanced Filters**: Date ranges, experience levels, skills

### Medium Term
- **Machine Learning**: Improved recommendation algorithm
- **Real-time Updates**: WebSocket integration for live updates
- **Analytics Dashboard**: Listing performance metrics

### Long Term
- **Elasticsearch**: Advanced search with faceted navigation
- **GraphQL**: More flexible API queries
- **Microservices**: Separate search service for scalability

---

## 🆘 Troubleshooting

### Common Issues

1. **Build Runner Fails**
   ```bash
   flutter packages pub run build_runner clean
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

2. **Location Permissions Denied**
   - Check platform-specific permission configurations
   - Test on physical device (permissions don't work in simulator)

3. **RPC Function Errors**
   - Verify all SQL functions are created in Supabase
   - Check function signatures match the repository calls
   - Review Supabase logs for detailed error messages

4. **Search Not Working**
   - Ensure `pg_trgm` extension is enabled
   - Verify search_vector trigger is working
   - Check that listings have `status = 'active'`

### Performance Issues

1. **Slow Queries**
   - Run `EXPLAIN ANALYZE` on the search RPC
   - Check if indexes are being used
   - Consider adding more specific indexes

2. **Memory Issues**
   - Implement proper pagination limits
   - Clear old listings data when refreshing
   - Monitor memory usage in Flutter DevTools

---

This comprehensive setup ensures you have a production-ready, performant listings feature that can scale with your user base while providing an excellent user experience.

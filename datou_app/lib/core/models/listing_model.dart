import 'package:freezed_annotation/freezed_annotation.dart';
import '../constants.dart';

part 'listing_model.freezed.dart';
part 'listing_model.g.dart';

enum ListingStatus { draft, active, paused, completed, cancelled }

enum ListingType { photography, videography, modeling, casting }

enum ContactMethod { in_app, email, phone }

enum ExperienceLevel { beginner, intermediate, advanced, professional }

enum SortOption { newest, oldest, budget_high, budget_low, deadline, recommended }

enum ViewMode { list, map }

// Category enums matching Supabase schema
enum PhotographyCategory {
  portrait, wedding, event, commercial, fashion, product,
  automotive, real_estate, sports, nature, street, lifestyle
}

enum VideographyCategory {
  commercial, wedding, music_video, documentary, corporate,
  social_media, event, promotional, real_estate, automotive
}

enum ModelingCategory {
  fashion, commercial, fitness, beauty, lifestyle, automotive,
  product, editorial, glamour, alternative
}

@freezed
class Listing with _$Listing {
  const factory Listing({
    required String id,
    @JsonKey(name: 'creator_id') required String creatorId,
    
    // Basic listing info
    required String title,
    required String description,
    required ListingType type,
    @JsonKey(name: 'required_role') UserRole? requiredRole,
    
    // Categories
    @JsonKey(name: 'photography_categories') List<PhotographyCategory>? photographyCategories,
    @JsonKey(name: 'videography_categories') List<VideographyCategory>? videographyCategories,
    @JsonKey(name: 'modeling_categories') List<ModelingCategory>? modelingCategories,
    
    // Budget and compensation
    double? budget,
    @JsonKey(name: 'is_negotiable') @Default(true) bool isNegotiable,
    
    // Location and geography
    @JsonKey(name: 'location_text') required String locationText,
    @JsonKey(name: 'is_remote') @Default(false) bool isRemote,
    
    // Timing
    @JsonKey(name: 'event_date') DateTime? eventDate,
    @JsonKey(name: 'event_duration_hours') int? eventDurationHours,
    @JsonKey(name: 'application_deadline') DateTime? applicationDeadline,
    
    // Requirements
    @JsonKey(name: 'required_skills') List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') ExperienceLevel? preferredExperience,
    @JsonKey(name: 'min_age') int? minAge,
    @JsonKey(name: 'max_age') int? maxAge,
    
    // Contact and application
    @JsonKey(name: 'contact_method') @Default(ContactMethod.in_app) ContactMethod contactMethod,
    @JsonKey(name: 'external_contact_info') String? externalContactInfo,
    
    // Media
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
    
    // Status and metadata
    @Default(ListingStatus.draft) ListingStatus status,
    @JsonKey(name: 'is_urgent') @Default(false) bool isUrgent,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    
    // Analytics
    @JsonKey(name: 'view_count') @Default(0) int viewCount,
    @JsonKey(name: 'application_count') @Default(0) int applicationCount,
    @JsonKey(name: 'save_count') @Default(0) int saveCount,
    
    // Search optimization
    List<String>? tags,
    
    // Timestamps
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    
    // Computed fields (from RPC)
    @JsonKey(name: 'distance_km') double? distanceKm,
    @JsonKey(name: 'is_saved') @Default(false) bool isSaved,
    @JsonKey(name: 'relevance_score') double? relevanceScore,
  }) = _Listing;

  factory Listing.fromJson(Map<String, dynamic> json) => _$ListingFromJson(json);
}

@freezed
class ListingFilters with _$ListingFilters {
  const factory ListingFilters({
    // Search and basic filtering
    String? searchQuery,
    List<ListingType>? types,
    List<UserRole>? roles,
    
    // Categories (flexible structure)
    Map<String, List<String>>? categories,
    
    // Budget filtering
    double? minBudget,
    double? maxBudget,
    bool? budgetNegotiable,
    
    // Location and geography
    double? userLat,
    double? userLng,
    int? maxDistanceKm,
    @Default(true) bool includeRemote,
    String? locationSearch,
    
    // Timing
    DateTime? eventDateFrom,
    DateTime? eventDateTo,
    DateTime? applicationDeadlineFrom,
    
    // Requirements
    List<String>? requiredSkills,
    List<ExperienceLevel>? experienceLevels,
    int? minAge,
    int? maxAge,
    
    // Flags
    @Default(false) bool urgentOnly,
    @Default(false) bool featuredOnly,
    
    // Sorting and view
    @Default(SortOption.newest) SortOption sortBy,
    @Default(ViewMode.list) ViewMode viewMode,
    
    // Pagination
    @Default(20) int pageLimit,
    @Default(0) int pageOffset,
  }) = _ListingFilters;

  factory ListingFilters.fromJson(Map<String, dynamic> json) => _$ListingFiltersFromJson(json);
}

@freezed
class ListingSearchResult with _$ListingSearchResult {
  const factory ListingSearchResult({
    required List<Listing> listings,
    required int totalCount,
    required bool hasMore,
    required int currentPage,
  }) = _ListingSearchResult;

  factory ListingSearchResult.fromJson(Map<String, dynamic> json) => _$ListingSearchResultFromJson(json);
}
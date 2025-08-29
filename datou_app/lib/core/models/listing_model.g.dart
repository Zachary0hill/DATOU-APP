// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListingImpl _$$ListingImplFromJson(Map<String, dynamic> json) =>
    _$ListingImpl(
      id: json['id'] as String,
      creatorId: json['creator_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$ListingTypeEnumMap, json['type']),
      requiredRole: $enumDecodeNullable(
        _$UserRoleEnumMap,
        json['required_role'],
      ),
      photographyCategories: (json['photography_categories'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PhotographyCategoryEnumMap, e))
          .toList(),
      videographyCategories: (json['videography_categories'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$VideographyCategoryEnumMap, e))
          .toList(),
      modelingCategories: (json['modeling_categories'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ModelingCategoryEnumMap, e))
          .toList(),
      budget: (json['budget'] as num?)?.toDouble(),
      isNegotiable: json['is_negotiable'] as bool? ?? true,
      locationText: json['location_text'] as String,
      isRemote: json['is_remote'] as bool? ?? false,
      eventDate: json['event_date'] == null
          ? null
          : DateTime.parse(json['event_date'] as String),
      eventDurationHours: (json['event_duration_hours'] as num?)?.toInt(),
      applicationDeadline: json['application_deadline'] == null
          ? null
          : DateTime.parse(json['application_deadline'] as String),
      requiredSkills: (json['required_skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferredExperience: $enumDecodeNullable(
        _$ExperienceLevelEnumMap,
        json['preferred_experience'],
      ),
      minAge: (json['min_age'] as num?)?.toInt(),
      maxAge: (json['max_age'] as num?)?.toInt(),
      contactMethod:
          $enumDecodeNullable(_$ContactMethodEnumMap, json['contact_method']) ??
          ContactMethod.in_app,
      externalContactInfo: json['external_contact_info'] as String?,
      imageUrls: (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status:
          $enumDecodeNullable(_$ListingStatusEnumMap, json['status']) ??
          ListingStatus.draft,
      isUrgent: json['is_urgent'] as bool? ?? false,
      isFeatured: json['is_featured'] as bool? ?? false,
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
      applicationCount: (json['application_count'] as num?)?.toInt() ?? 0,
      saveCount: (json['save_count'] as num?)?.toInt() ?? 0,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      distanceKm: (json['distance_km'] as num?)?.toDouble(),
      isSaved: json['is_saved'] as bool? ?? false,
      relevanceScore: (json['relevance_score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ListingImplToJson(_$ListingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'title': instance.title,
      'description': instance.description,
      'type': _$ListingTypeEnumMap[instance.type]!,
      'required_role': _$UserRoleEnumMap[instance.requiredRole],
      'photography_categories': instance.photographyCategories
          ?.map((e) => _$PhotographyCategoryEnumMap[e]!)
          .toList(),
      'videography_categories': instance.videographyCategories
          ?.map((e) => _$VideographyCategoryEnumMap[e]!)
          .toList(),
      'modeling_categories': instance.modelingCategories
          ?.map((e) => _$ModelingCategoryEnumMap[e]!)
          .toList(),
      'budget': instance.budget,
      'is_negotiable': instance.isNegotiable,
      'location_text': instance.locationText,
      'is_remote': instance.isRemote,
      'event_date': instance.eventDate?.toIso8601String(),
      'event_duration_hours': instance.eventDurationHours,
      'application_deadline': instance.applicationDeadline?.toIso8601String(),
      'required_skills': instance.requiredSkills,
      'preferred_experience':
          _$ExperienceLevelEnumMap[instance.preferredExperience],
      'min_age': instance.minAge,
      'max_age': instance.maxAge,
      'contact_method': _$ContactMethodEnumMap[instance.contactMethod]!,
      'external_contact_info': instance.externalContactInfo,
      'image_urls': instance.imageUrls,
      'status': _$ListingStatusEnumMap[instance.status]!,
      'is_urgent': instance.isUrgent,
      'is_featured': instance.isFeatured,
      'view_count': instance.viewCount,
      'application_count': instance.applicationCount,
      'save_count': instance.saveCount,
      'tags': instance.tags,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'distance_km': instance.distanceKm,
      'is_saved': instance.isSaved,
      'relevance_score': instance.relevanceScore,
    };

const _$ListingTypeEnumMap = {
  ListingType.photography: 'photography',
  ListingType.videography: 'videography',
  ListingType.modeling: 'modeling',
  ListingType.casting: 'casting',
};

const _$UserRoleEnumMap = {
  UserRole.photographer: 'photographer',
  UserRole.videographer: 'videographer',
  UserRole.model: 'model',
  UserRole.agency: 'agency',
};

const _$PhotographyCategoryEnumMap = {
  PhotographyCategory.portrait: 'portrait',
  PhotographyCategory.wedding: 'wedding',
  PhotographyCategory.event: 'event',
  PhotographyCategory.commercial: 'commercial',
  PhotographyCategory.fashion: 'fashion',
  PhotographyCategory.product: 'product',
  PhotographyCategory.automotive: 'automotive',
  PhotographyCategory.real_estate: 'real_estate',
  PhotographyCategory.sports: 'sports',
  PhotographyCategory.nature: 'nature',
  PhotographyCategory.street: 'street',
  PhotographyCategory.lifestyle: 'lifestyle',
};

const _$VideographyCategoryEnumMap = {
  VideographyCategory.commercial: 'commercial',
  VideographyCategory.wedding: 'wedding',
  VideographyCategory.music_video: 'music_video',
  VideographyCategory.documentary: 'documentary',
  VideographyCategory.corporate: 'corporate',
  VideographyCategory.social_media: 'social_media',
  VideographyCategory.event: 'event',
  VideographyCategory.promotional: 'promotional',
  VideographyCategory.real_estate: 'real_estate',
  VideographyCategory.automotive: 'automotive',
};

const _$ModelingCategoryEnumMap = {
  ModelingCategory.fashion: 'fashion',
  ModelingCategory.commercial: 'commercial',
  ModelingCategory.fitness: 'fitness',
  ModelingCategory.beauty: 'beauty',
  ModelingCategory.lifestyle: 'lifestyle',
  ModelingCategory.automotive: 'automotive',
  ModelingCategory.product: 'product',
  ModelingCategory.editorial: 'editorial',
  ModelingCategory.glamour: 'glamour',
  ModelingCategory.alternative: 'alternative',
};

const _$ExperienceLevelEnumMap = {
  ExperienceLevel.beginner: 'beginner',
  ExperienceLevel.intermediate: 'intermediate',
  ExperienceLevel.advanced: 'advanced',
  ExperienceLevel.professional: 'professional',
};

const _$ContactMethodEnumMap = {
  ContactMethod.in_app: 'in_app',
  ContactMethod.email: 'email',
  ContactMethod.phone: 'phone',
};

const _$ListingStatusEnumMap = {
  ListingStatus.draft: 'draft',
  ListingStatus.active: 'active',
  ListingStatus.paused: 'paused',
  ListingStatus.completed: 'completed',
  ListingStatus.cancelled: 'cancelled',
};

_$ListingFiltersImpl _$$ListingFiltersImplFromJson(Map<String, dynamic> json) =>
    _$ListingFiltersImpl(
      searchQuery: json['searchQuery'] as String?,
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ListingTypeEnumMap, e))
          .toList(),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$UserRoleEnumMap, e))
          .toList(),
      categories: (json['categories'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      minBudget: (json['minBudget'] as num?)?.toDouble(),
      maxBudget: (json['maxBudget'] as num?)?.toDouble(),
      budgetNegotiable: json['budgetNegotiable'] as bool?,
      userLat: (json['userLat'] as num?)?.toDouble(),
      userLng: (json['userLng'] as num?)?.toDouble(),
      maxDistanceKm: (json['maxDistanceKm'] as num?)?.toInt(),
      includeRemote: json['includeRemote'] as bool? ?? true,
      locationSearch: json['locationSearch'] as String?,
      eventDateFrom: json['eventDateFrom'] == null
          ? null
          : DateTime.parse(json['eventDateFrom'] as String),
      eventDateTo: json['eventDateTo'] == null
          ? null
          : DateTime.parse(json['eventDateTo'] as String),
      applicationDeadlineFrom: json['applicationDeadlineFrom'] == null
          ? null
          : DateTime.parse(json['applicationDeadlineFrom'] as String),
      requiredSkills: (json['requiredSkills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      experienceLevels: (json['experienceLevels'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ExperienceLevelEnumMap, e))
          .toList(),
      minAge: (json['minAge'] as num?)?.toInt(),
      maxAge: (json['maxAge'] as num?)?.toInt(),
      urgentOnly: json['urgentOnly'] as bool? ?? false,
      featuredOnly: json['featuredOnly'] as bool? ?? false,
      sortBy:
          $enumDecodeNullable(_$SortOptionEnumMap, json['sortBy']) ??
          SortOption.newest,
      viewMode:
          $enumDecodeNullable(_$ViewModeEnumMap, json['viewMode']) ??
          ViewMode.list,
      pageLimit: (json['pageLimit'] as num?)?.toInt() ?? 20,
      pageOffset: (json['pageOffset'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ListingFiltersImplToJson(
  _$ListingFiltersImpl instance,
) => <String, dynamic>{
  'searchQuery': instance.searchQuery,
  'types': instance.types?.map((e) => _$ListingTypeEnumMap[e]!).toList(),
  'roles': instance.roles?.map((e) => _$UserRoleEnumMap[e]!).toList(),
  'categories': instance.categories,
  'minBudget': instance.minBudget,
  'maxBudget': instance.maxBudget,
  'budgetNegotiable': instance.budgetNegotiable,
  'userLat': instance.userLat,
  'userLng': instance.userLng,
  'maxDistanceKm': instance.maxDistanceKm,
  'includeRemote': instance.includeRemote,
  'locationSearch': instance.locationSearch,
  'eventDateFrom': instance.eventDateFrom?.toIso8601String(),
  'eventDateTo': instance.eventDateTo?.toIso8601String(),
  'applicationDeadlineFrom': instance.applicationDeadlineFrom
      ?.toIso8601String(),
  'requiredSkills': instance.requiredSkills,
  'experienceLevels': instance.experienceLevels
      ?.map((e) => _$ExperienceLevelEnumMap[e]!)
      .toList(),
  'minAge': instance.minAge,
  'maxAge': instance.maxAge,
  'urgentOnly': instance.urgentOnly,
  'featuredOnly': instance.featuredOnly,
  'sortBy': _$SortOptionEnumMap[instance.sortBy]!,
  'viewMode': _$ViewModeEnumMap[instance.viewMode]!,
  'pageLimit': instance.pageLimit,
  'pageOffset': instance.pageOffset,
};

const _$SortOptionEnumMap = {
  SortOption.newest: 'newest',
  SortOption.oldest: 'oldest',
  SortOption.budget_high: 'budget_high',
  SortOption.budget_low: 'budget_low',
  SortOption.deadline: 'deadline',
  SortOption.recommended: 'recommended',
};

const _$ViewModeEnumMap = {ViewMode.list: 'list', ViewMode.map: 'map'};

_$ListingSearchResultImpl _$$ListingSearchResultImplFromJson(
  Map<String, dynamic> json,
) => _$ListingSearchResultImpl(
  listings: (json['listings'] as List<dynamic>)
      .map((e) => Listing.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasMore: json['hasMore'] as bool,
  currentPage: (json['currentPage'] as num).toInt(),
);

Map<String, dynamic> _$$ListingSearchResultImplToJson(
  _$ListingSearchResultImpl instance,
) => <String, dynamic>{
  'listings': instance.listings,
  'totalCount': instance.totalCount,
  'hasMore': instance.hasMore,
  'currentPage': instance.currentPage,
};

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Listing _$ListingFromJson(Map<String, dynamic> json) {
  return _Listing.fromJson(json);
}

/// @nodoc
mixin _$Listing {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'creator_id')
  String get creatorId => throw _privateConstructorUsedError; // Basic listing info
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ListingType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'required_role')
  UserRole? get requiredRole => throw _privateConstructorUsedError; // Categories
  @JsonKey(name: 'photography_categories')
  List<PhotographyCategory>? get photographyCategories =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'videography_categories')
  List<VideographyCategory>? get videographyCategories =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'modeling_categories')
  List<ModelingCategory>? get modelingCategories =>
      throw _privateConstructorUsedError; // Budget and compensation
  double? get budget => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_negotiable')
  bool get isNegotiable => throw _privateConstructorUsedError; // Location and geography
  @JsonKey(name: 'location_text')
  String get locationText => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_remote')
  bool get isRemote => throw _privateConstructorUsedError; // Timing
  @JsonKey(name: 'event_date')
  DateTime? get eventDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_duration_hours')
  int? get eventDurationHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'application_deadline')
  DateTime? get applicationDeadline => throw _privateConstructorUsedError; // Requirements
  @JsonKey(name: 'required_skills')
  List<String>? get requiredSkills => throw _privateConstructorUsedError;
  @JsonKey(name: 'preferred_experience')
  ExperienceLevel? get preferredExperience =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'min_age')
  int? get minAge => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_age')
  int? get maxAge => throw _privateConstructorUsedError; // Contact and application
  @JsonKey(name: 'contact_method')
  ContactMethod get contactMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'external_contact_info')
  String? get externalContactInfo => throw _privateConstructorUsedError; // Media
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls => throw _privateConstructorUsedError; // Status and metadata
  ListingStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_urgent')
  bool get isUrgent => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_featured')
  bool get isFeatured => throw _privateConstructorUsedError; // Analytics
  @JsonKey(name: 'view_count')
  int get viewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'application_count')
  int get applicationCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'save_count')
  int get saveCount => throw _privateConstructorUsedError; // Search optimization
  List<String>? get tags => throw _privateConstructorUsedError; // Timestamps
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError; // Computed fields (from RPC)
  @JsonKey(name: 'distance_km')
  double? get distanceKm => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_saved')
  bool get isSaved => throw _privateConstructorUsedError;
  @JsonKey(name: 'relevance_score')
  double? get relevanceScore => throw _privateConstructorUsedError;

  /// Serializes this Listing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingCopyWith<Listing> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingCopyWith<$Res> {
  factory $ListingCopyWith(Listing value, $Res Function(Listing) then) =
      _$ListingCopyWithImpl<$Res, Listing>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'creator_id') String creatorId,
    String title,
    String description,
    ListingType type,
    @JsonKey(name: 'required_role') UserRole? requiredRole,
    @JsonKey(name: 'photography_categories')
    List<PhotographyCategory>? photographyCategories,
    @JsonKey(name: 'videography_categories')
    List<VideographyCategory>? videographyCategories,
    @JsonKey(name: 'modeling_categories')
    List<ModelingCategory>? modelingCategories,
    double? budget,
    @JsonKey(name: 'is_negotiable') bool isNegotiable,
    @JsonKey(name: 'location_text') String locationText,
    @JsonKey(name: 'is_remote') bool isRemote,
    @JsonKey(name: 'event_date') DateTime? eventDate,
    @JsonKey(name: 'event_duration_hours') int? eventDurationHours,
    @JsonKey(name: 'application_deadline') DateTime? applicationDeadline,
    @JsonKey(name: 'required_skills') List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') ExperienceLevel? preferredExperience,
    @JsonKey(name: 'min_age') int? minAge,
    @JsonKey(name: 'max_age') int? maxAge,
    @JsonKey(name: 'contact_method') ContactMethod contactMethod,
    @JsonKey(name: 'external_contact_info') String? externalContactInfo,
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
    ListingStatus status,
    @JsonKey(name: 'is_urgent') bool isUrgent,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'application_count') int applicationCount,
    @JsonKey(name: 'save_count') int saveCount,
    List<String>? tags,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'distance_km') double? distanceKm,
    @JsonKey(name: 'is_saved') bool isSaved,
    @JsonKey(name: 'relevance_score') double? relevanceScore,
  });
}

/// @nodoc
class _$ListingCopyWithImpl<$Res, $Val extends Listing>
    implements $ListingCopyWith<$Res> {
  _$ListingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorId = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? requiredRole = freezed,
    Object? photographyCategories = freezed,
    Object? videographyCategories = freezed,
    Object? modelingCategories = freezed,
    Object? budget = freezed,
    Object? isNegotiable = null,
    Object? locationText = null,
    Object? isRemote = null,
    Object? eventDate = freezed,
    Object? eventDurationHours = freezed,
    Object? applicationDeadline = freezed,
    Object? requiredSkills = freezed,
    Object? preferredExperience = freezed,
    Object? minAge = freezed,
    Object? maxAge = freezed,
    Object? contactMethod = null,
    Object? externalContactInfo = freezed,
    Object? imageUrls = freezed,
    Object? status = null,
    Object? isUrgent = null,
    Object? isFeatured = null,
    Object? viewCount = null,
    Object? applicationCount = null,
    Object? saveCount = null,
    Object? tags = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? expiresAt = freezed,
    Object? distanceKm = freezed,
    Object? isSaved = null,
    Object? relevanceScore = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            creatorId: null == creatorId
                ? _value.creatorId
                : creatorId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ListingType,
            requiredRole: freezed == requiredRole
                ? _value.requiredRole
                : requiredRole // ignore: cast_nullable_to_non_nullable
                      as UserRole?,
            photographyCategories: freezed == photographyCategories
                ? _value.photographyCategories
                : photographyCategories // ignore: cast_nullable_to_non_nullable
                      as List<PhotographyCategory>?,
            videographyCategories: freezed == videographyCategories
                ? _value.videographyCategories
                : videographyCategories // ignore: cast_nullable_to_non_nullable
                      as List<VideographyCategory>?,
            modelingCategories: freezed == modelingCategories
                ? _value.modelingCategories
                : modelingCategories // ignore: cast_nullable_to_non_nullable
                      as List<ModelingCategory>?,
            budget: freezed == budget
                ? _value.budget
                : budget // ignore: cast_nullable_to_non_nullable
                      as double?,
            isNegotiable: null == isNegotiable
                ? _value.isNegotiable
                : isNegotiable // ignore: cast_nullable_to_non_nullable
                      as bool,
            locationText: null == locationText
                ? _value.locationText
                : locationText // ignore: cast_nullable_to_non_nullable
                      as String,
            isRemote: null == isRemote
                ? _value.isRemote
                : isRemote // ignore: cast_nullable_to_non_nullable
                      as bool,
            eventDate: freezed == eventDate
                ? _value.eventDate
                : eventDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            eventDurationHours: freezed == eventDurationHours
                ? _value.eventDurationHours
                : eventDurationHours // ignore: cast_nullable_to_non_nullable
                      as int?,
            applicationDeadline: freezed == applicationDeadline
                ? _value.applicationDeadline
                : applicationDeadline // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            requiredSkills: freezed == requiredSkills
                ? _value.requiredSkills
                : requiredSkills // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            preferredExperience: freezed == preferredExperience
                ? _value.preferredExperience
                : preferredExperience // ignore: cast_nullable_to_non_nullable
                      as ExperienceLevel?,
            minAge: freezed == minAge
                ? _value.minAge
                : minAge // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxAge: freezed == maxAge
                ? _value.maxAge
                : maxAge // ignore: cast_nullable_to_non_nullable
                      as int?,
            contactMethod: null == contactMethod
                ? _value.contactMethod
                : contactMethod // ignore: cast_nullable_to_non_nullable
                      as ContactMethod,
            externalContactInfo: freezed == externalContactInfo
                ? _value.externalContactInfo
                : externalContactInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrls: freezed == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ListingStatus,
            isUrgent: null == isUrgent
                ? _value.isUrgent
                : isUrgent // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            applicationCount: null == applicationCount
                ? _value.applicationCount
                : applicationCount // ignore: cast_nullable_to_non_nullable
                      as int,
            saveCount: null == saveCount
                ? _value.saveCount
                : saveCount // ignore: cast_nullable_to_non_nullable
                      as int,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            distanceKm: freezed == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double?,
            isSaved: null == isSaved
                ? _value.isSaved
                : isSaved // ignore: cast_nullable_to_non_nullable
                      as bool,
            relevanceScore: freezed == relevanceScore
                ? _value.relevanceScore
                : relevanceScore // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingImplCopyWith<$Res> implements $ListingCopyWith<$Res> {
  factory _$$ListingImplCopyWith(
    _$ListingImpl value,
    $Res Function(_$ListingImpl) then,
  ) = __$$ListingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'creator_id') String creatorId,
    String title,
    String description,
    ListingType type,
    @JsonKey(name: 'required_role') UserRole? requiredRole,
    @JsonKey(name: 'photography_categories')
    List<PhotographyCategory>? photographyCategories,
    @JsonKey(name: 'videography_categories')
    List<VideographyCategory>? videographyCategories,
    @JsonKey(name: 'modeling_categories')
    List<ModelingCategory>? modelingCategories,
    double? budget,
    @JsonKey(name: 'is_negotiable') bool isNegotiable,
    @JsonKey(name: 'location_text') String locationText,
    @JsonKey(name: 'is_remote') bool isRemote,
    @JsonKey(name: 'event_date') DateTime? eventDate,
    @JsonKey(name: 'event_duration_hours') int? eventDurationHours,
    @JsonKey(name: 'application_deadline') DateTime? applicationDeadline,
    @JsonKey(name: 'required_skills') List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') ExperienceLevel? preferredExperience,
    @JsonKey(name: 'min_age') int? minAge,
    @JsonKey(name: 'max_age') int? maxAge,
    @JsonKey(name: 'contact_method') ContactMethod contactMethod,
    @JsonKey(name: 'external_contact_info') String? externalContactInfo,
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
    ListingStatus status,
    @JsonKey(name: 'is_urgent') bool isUrgent,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'application_count') int applicationCount,
    @JsonKey(name: 'save_count') int saveCount,
    List<String>? tags,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'distance_km') double? distanceKm,
    @JsonKey(name: 'is_saved') bool isSaved,
    @JsonKey(name: 'relevance_score') double? relevanceScore,
  });
}

/// @nodoc
class __$$ListingImplCopyWithImpl<$Res>
    extends _$ListingCopyWithImpl<$Res, _$ListingImpl>
    implements _$$ListingImplCopyWith<$Res> {
  __$$ListingImplCopyWithImpl(
    _$ListingImpl _value,
    $Res Function(_$ListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorId = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? requiredRole = freezed,
    Object? photographyCategories = freezed,
    Object? videographyCategories = freezed,
    Object? modelingCategories = freezed,
    Object? budget = freezed,
    Object? isNegotiable = null,
    Object? locationText = null,
    Object? isRemote = null,
    Object? eventDate = freezed,
    Object? eventDurationHours = freezed,
    Object? applicationDeadline = freezed,
    Object? requiredSkills = freezed,
    Object? preferredExperience = freezed,
    Object? minAge = freezed,
    Object? maxAge = freezed,
    Object? contactMethod = null,
    Object? externalContactInfo = freezed,
    Object? imageUrls = freezed,
    Object? status = null,
    Object? isUrgent = null,
    Object? isFeatured = null,
    Object? viewCount = null,
    Object? applicationCount = null,
    Object? saveCount = null,
    Object? tags = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? expiresAt = freezed,
    Object? distanceKm = freezed,
    Object? isSaved = null,
    Object? relevanceScore = freezed,
  }) {
    return _then(
      _$ListingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        creatorId: null == creatorId
            ? _value.creatorId
            : creatorId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ListingType,
        requiredRole: freezed == requiredRole
            ? _value.requiredRole
            : requiredRole // ignore: cast_nullable_to_non_nullable
                  as UserRole?,
        photographyCategories: freezed == photographyCategories
            ? _value._photographyCategories
            : photographyCategories // ignore: cast_nullable_to_non_nullable
                  as List<PhotographyCategory>?,
        videographyCategories: freezed == videographyCategories
            ? _value._videographyCategories
            : videographyCategories // ignore: cast_nullable_to_non_nullable
                  as List<VideographyCategory>?,
        modelingCategories: freezed == modelingCategories
            ? _value._modelingCategories
            : modelingCategories // ignore: cast_nullable_to_non_nullable
                  as List<ModelingCategory>?,
        budget: freezed == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as double?,
        isNegotiable: null == isNegotiable
            ? _value.isNegotiable
            : isNegotiable // ignore: cast_nullable_to_non_nullable
                  as bool,
        locationText: null == locationText
            ? _value.locationText
            : locationText // ignore: cast_nullable_to_non_nullable
                  as String,
        isRemote: null == isRemote
            ? _value.isRemote
            : isRemote // ignore: cast_nullable_to_non_nullable
                  as bool,
        eventDate: freezed == eventDate
            ? _value.eventDate
            : eventDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        eventDurationHours: freezed == eventDurationHours
            ? _value.eventDurationHours
            : eventDurationHours // ignore: cast_nullable_to_non_nullable
                  as int?,
        applicationDeadline: freezed == applicationDeadline
            ? _value.applicationDeadline
            : applicationDeadline // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        requiredSkills: freezed == requiredSkills
            ? _value._requiredSkills
            : requiredSkills // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        preferredExperience: freezed == preferredExperience
            ? _value.preferredExperience
            : preferredExperience // ignore: cast_nullable_to_non_nullable
                  as ExperienceLevel?,
        minAge: freezed == minAge
            ? _value.minAge
            : minAge // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxAge: freezed == maxAge
            ? _value.maxAge
            : maxAge // ignore: cast_nullable_to_non_nullable
                  as int?,
        contactMethod: null == contactMethod
            ? _value.contactMethod
            : contactMethod // ignore: cast_nullable_to_non_nullable
                  as ContactMethod,
        externalContactInfo: freezed == externalContactInfo
            ? _value.externalContactInfo
            : externalContactInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrls: freezed == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ListingStatus,
        isUrgent: null == isUrgent
            ? _value.isUrgent
            : isUrgent // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        applicationCount: null == applicationCount
            ? _value.applicationCount
            : applicationCount // ignore: cast_nullable_to_non_nullable
                  as int,
        saveCount: null == saveCount
            ? _value.saveCount
            : saveCount // ignore: cast_nullable_to_non_nullable
                  as int,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        distanceKm: freezed == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double?,
        isSaved: null == isSaved
            ? _value.isSaved
            : isSaved // ignore: cast_nullable_to_non_nullable
                  as bool,
        relevanceScore: freezed == relevanceScore
            ? _value.relevanceScore
            : relevanceScore // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingImpl implements _Listing {
  const _$ListingImpl({
    required this.id,
    @JsonKey(name: 'creator_id') required this.creatorId,
    required this.title,
    required this.description,
    required this.type,
    @JsonKey(name: 'required_role') this.requiredRole,
    @JsonKey(name: 'photography_categories')
    final List<PhotographyCategory>? photographyCategories,
    @JsonKey(name: 'videography_categories')
    final List<VideographyCategory>? videographyCategories,
    @JsonKey(name: 'modeling_categories')
    final List<ModelingCategory>? modelingCategories,
    this.budget,
    @JsonKey(name: 'is_negotiable') this.isNegotiable = true,
    @JsonKey(name: 'location_text') required this.locationText,
    @JsonKey(name: 'is_remote') this.isRemote = false,
    @JsonKey(name: 'event_date') this.eventDate,
    @JsonKey(name: 'event_duration_hours') this.eventDurationHours,
    @JsonKey(name: 'application_deadline') this.applicationDeadline,
    @JsonKey(name: 'required_skills') final List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') this.preferredExperience,
    @JsonKey(name: 'min_age') this.minAge,
    @JsonKey(name: 'max_age') this.maxAge,
    @JsonKey(name: 'contact_method') this.contactMethod = ContactMethod.in_app,
    @JsonKey(name: 'external_contact_info') this.externalContactInfo,
    @JsonKey(name: 'image_urls') final List<String>? imageUrls,
    this.status = ListingStatus.draft,
    @JsonKey(name: 'is_urgent') this.isUrgent = false,
    @JsonKey(name: 'is_featured') this.isFeatured = false,
    @JsonKey(name: 'view_count') this.viewCount = 0,
    @JsonKey(name: 'application_count') this.applicationCount = 0,
    @JsonKey(name: 'save_count') this.saveCount = 0,
    final List<String>? tags,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    @JsonKey(name: 'expires_at') this.expiresAt,
    @JsonKey(name: 'distance_km') this.distanceKm,
    @JsonKey(name: 'is_saved') this.isSaved = false,
    @JsonKey(name: 'relevance_score') this.relevanceScore,
  }) : _photographyCategories = photographyCategories,
       _videographyCategories = videographyCategories,
       _modelingCategories = modelingCategories,
       _requiredSkills = requiredSkills,
       _imageUrls = imageUrls,
       _tags = tags;

  factory _$ListingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'creator_id')
  final String creatorId;
  // Basic listing info
  @override
  final String title;
  @override
  final String description;
  @override
  final ListingType type;
  @override
  @JsonKey(name: 'required_role')
  final UserRole? requiredRole;
  // Categories
  final List<PhotographyCategory>? _photographyCategories;
  // Categories
  @override
  @JsonKey(name: 'photography_categories')
  List<PhotographyCategory>? get photographyCategories {
    final value = _photographyCategories;
    if (value == null) return null;
    if (_photographyCategories is EqualUnmodifiableListView)
      return _photographyCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<VideographyCategory>? _videographyCategories;
  @override
  @JsonKey(name: 'videography_categories')
  List<VideographyCategory>? get videographyCategories {
    final value = _videographyCategories;
    if (value == null) return null;
    if (_videographyCategories is EqualUnmodifiableListView)
      return _videographyCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ModelingCategory>? _modelingCategories;
  @override
  @JsonKey(name: 'modeling_categories')
  List<ModelingCategory>? get modelingCategories {
    final value = _modelingCategories;
    if (value == null) return null;
    if (_modelingCategories is EqualUnmodifiableListView)
      return _modelingCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Budget and compensation
  @override
  final double? budget;
  @override
  @JsonKey(name: 'is_negotiable')
  final bool isNegotiable;
  // Location and geography
  @override
  @JsonKey(name: 'location_text')
  final String locationText;
  @override
  @JsonKey(name: 'is_remote')
  final bool isRemote;
  // Timing
  @override
  @JsonKey(name: 'event_date')
  final DateTime? eventDate;
  @override
  @JsonKey(name: 'event_duration_hours')
  final int? eventDurationHours;
  @override
  @JsonKey(name: 'application_deadline')
  final DateTime? applicationDeadline;
  // Requirements
  final List<String>? _requiredSkills;
  // Requirements
  @override
  @JsonKey(name: 'required_skills')
  List<String>? get requiredSkills {
    final value = _requiredSkills;
    if (value == null) return null;
    if (_requiredSkills is EqualUnmodifiableListView) return _requiredSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'preferred_experience')
  final ExperienceLevel? preferredExperience;
  @override
  @JsonKey(name: 'min_age')
  final int? minAge;
  @override
  @JsonKey(name: 'max_age')
  final int? maxAge;
  // Contact and application
  @override
  @JsonKey(name: 'contact_method')
  final ContactMethod contactMethod;
  @override
  @JsonKey(name: 'external_contact_info')
  final String? externalContactInfo;
  // Media
  final List<String>? _imageUrls;
  // Media
  @override
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Status and metadata
  @override
  @JsonKey()
  final ListingStatus status;
  @override
  @JsonKey(name: 'is_urgent')
  final bool isUrgent;
  @override
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  // Analytics
  @override
  @JsonKey(name: 'view_count')
  final int viewCount;
  @override
  @JsonKey(name: 'application_count')
  final int applicationCount;
  @override
  @JsonKey(name: 'save_count')
  final int saveCount;
  // Search optimization
  final List<String>? _tags;
  // Search optimization
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  // Computed fields (from RPC)
  @override
  @JsonKey(name: 'distance_km')
  final double? distanceKm;
  @override
  @JsonKey(name: 'is_saved')
  final bool isSaved;
  @override
  @JsonKey(name: 'relevance_score')
  final double? relevanceScore;

  @override
  String toString() {
    return 'Listing(id: $id, creatorId: $creatorId, title: $title, description: $description, type: $type, requiredRole: $requiredRole, photographyCategories: $photographyCategories, videographyCategories: $videographyCategories, modelingCategories: $modelingCategories, budget: $budget, isNegotiable: $isNegotiable, locationText: $locationText, isRemote: $isRemote, eventDate: $eventDate, eventDurationHours: $eventDurationHours, applicationDeadline: $applicationDeadline, requiredSkills: $requiredSkills, preferredExperience: $preferredExperience, minAge: $minAge, maxAge: $maxAge, contactMethod: $contactMethod, externalContactInfo: $externalContactInfo, imageUrls: $imageUrls, status: $status, isUrgent: $isUrgent, isFeatured: $isFeatured, viewCount: $viewCount, applicationCount: $applicationCount, saveCount: $saveCount, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, distanceKm: $distanceKm, isSaved: $isSaved, relevanceScore: $relevanceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.requiredRole, requiredRole) ||
                other.requiredRole == requiredRole) &&
            const DeepCollectionEquality().equals(
              other._photographyCategories,
              _photographyCategories,
            ) &&
            const DeepCollectionEquality().equals(
              other._videographyCategories,
              _videographyCategories,
            ) &&
            const DeepCollectionEquality().equals(
              other._modelingCategories,
              _modelingCategories,
            ) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.isNegotiable, isNegotiable) ||
                other.isNegotiable == isNegotiable) &&
            (identical(other.locationText, locationText) ||
                other.locationText == locationText) &&
            (identical(other.isRemote, isRemote) ||
                other.isRemote == isRemote) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.eventDurationHours, eventDurationHours) ||
                other.eventDurationHours == eventDurationHours) &&
            (identical(other.applicationDeadline, applicationDeadline) ||
                other.applicationDeadline == applicationDeadline) &&
            const DeepCollectionEquality().equals(
              other._requiredSkills,
              _requiredSkills,
            ) &&
            (identical(other.preferredExperience, preferredExperience) ||
                other.preferredExperience == preferredExperience) &&
            (identical(other.minAge, minAge) || other.minAge == minAge) &&
            (identical(other.maxAge, maxAge) || other.maxAge == maxAge) &&
            (identical(other.contactMethod, contactMethod) ||
                other.contactMethod == contactMethod) &&
            (identical(other.externalContactInfo, externalContactInfo) ||
                other.externalContactInfo == externalContactInfo) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.applicationCount, applicationCount) ||
                other.applicationCount == applicationCount) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.relevanceScore, relevanceScore) ||
                other.relevanceScore == relevanceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    creatorId,
    title,
    description,
    type,
    requiredRole,
    const DeepCollectionEquality().hash(_photographyCategories),
    const DeepCollectionEquality().hash(_videographyCategories),
    const DeepCollectionEquality().hash(_modelingCategories),
    budget,
    isNegotiable,
    locationText,
    isRemote,
    eventDate,
    eventDurationHours,
    applicationDeadline,
    const DeepCollectionEquality().hash(_requiredSkills),
    preferredExperience,
    minAge,
    maxAge,
    contactMethod,
    externalContactInfo,
    const DeepCollectionEquality().hash(_imageUrls),
    status,
    isUrgent,
    isFeatured,
    viewCount,
    applicationCount,
    saveCount,
    const DeepCollectionEquality().hash(_tags),
    createdAt,
    updatedAt,
    expiresAt,
    distanceKm,
    isSaved,
    relevanceScore,
  ]);

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingImplCopyWith<_$ListingImpl> get copyWith =>
      __$$ListingImplCopyWithImpl<_$ListingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingImplToJson(this);
  }
}

abstract class _Listing implements Listing {
  const factory _Listing({
    required final String id,
    @JsonKey(name: 'creator_id') required final String creatorId,
    required final String title,
    required final String description,
    required final ListingType type,
    @JsonKey(name: 'required_role') final UserRole? requiredRole,
    @JsonKey(name: 'photography_categories')
    final List<PhotographyCategory>? photographyCategories,
    @JsonKey(name: 'videography_categories')
    final List<VideographyCategory>? videographyCategories,
    @JsonKey(name: 'modeling_categories')
    final List<ModelingCategory>? modelingCategories,
    final double? budget,
    @JsonKey(name: 'is_negotiable') final bool isNegotiable,
    @JsonKey(name: 'location_text') required final String locationText,
    @JsonKey(name: 'is_remote') final bool isRemote,
    @JsonKey(name: 'event_date') final DateTime? eventDate,
    @JsonKey(name: 'event_duration_hours') final int? eventDurationHours,
    @JsonKey(name: 'application_deadline') final DateTime? applicationDeadline,
    @JsonKey(name: 'required_skills') final List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience')
    final ExperienceLevel? preferredExperience,
    @JsonKey(name: 'min_age') final int? minAge,
    @JsonKey(name: 'max_age') final int? maxAge,
    @JsonKey(name: 'contact_method') final ContactMethod contactMethod,
    @JsonKey(name: 'external_contact_info') final String? externalContactInfo,
    @JsonKey(name: 'image_urls') final List<String>? imageUrls,
    final ListingStatus status,
    @JsonKey(name: 'is_urgent') final bool isUrgent,
    @JsonKey(name: 'is_featured') final bool isFeatured,
    @JsonKey(name: 'view_count') final int viewCount,
    @JsonKey(name: 'application_count') final int applicationCount,
    @JsonKey(name: 'save_count') final int saveCount,
    final List<String>? tags,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    @JsonKey(name: 'expires_at') final DateTime? expiresAt,
    @JsonKey(name: 'distance_km') final double? distanceKm,
    @JsonKey(name: 'is_saved') final bool isSaved,
    @JsonKey(name: 'relevance_score') final double? relevanceScore,
  }) = _$ListingImpl;

  factory _Listing.fromJson(Map<String, dynamic> json) = _$ListingImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'creator_id')
  String get creatorId; // Basic listing info
  @override
  String get title;
  @override
  String get description;
  @override
  ListingType get type;
  @override
  @JsonKey(name: 'required_role')
  UserRole? get requiredRole; // Categories
  @override
  @JsonKey(name: 'photography_categories')
  List<PhotographyCategory>? get photographyCategories;
  @override
  @JsonKey(name: 'videography_categories')
  List<VideographyCategory>? get videographyCategories;
  @override
  @JsonKey(name: 'modeling_categories')
  List<ModelingCategory>? get modelingCategories; // Budget and compensation
  @override
  double? get budget;
  @override
  @JsonKey(name: 'is_negotiable')
  bool get isNegotiable; // Location and geography
  @override
  @JsonKey(name: 'location_text')
  String get locationText;
  @override
  @JsonKey(name: 'is_remote')
  bool get isRemote; // Timing
  @override
  @JsonKey(name: 'event_date')
  DateTime? get eventDate;
  @override
  @JsonKey(name: 'event_duration_hours')
  int? get eventDurationHours;
  @override
  @JsonKey(name: 'application_deadline')
  DateTime? get applicationDeadline; // Requirements
  @override
  @JsonKey(name: 'required_skills')
  List<String>? get requiredSkills;
  @override
  @JsonKey(name: 'preferred_experience')
  ExperienceLevel? get preferredExperience;
  @override
  @JsonKey(name: 'min_age')
  int? get minAge;
  @override
  @JsonKey(name: 'max_age')
  int? get maxAge; // Contact and application
  @override
  @JsonKey(name: 'contact_method')
  ContactMethod get contactMethod;
  @override
  @JsonKey(name: 'external_contact_info')
  String? get externalContactInfo; // Media
  @override
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls; // Status and metadata
  @override
  ListingStatus get status;
  @override
  @JsonKey(name: 'is_urgent')
  bool get isUrgent;
  @override
  @JsonKey(name: 'is_featured')
  bool get isFeatured; // Analytics
  @override
  @JsonKey(name: 'view_count')
  int get viewCount;
  @override
  @JsonKey(name: 'application_count')
  int get applicationCount;
  @override
  @JsonKey(name: 'save_count')
  int get saveCount; // Search optimization
  @override
  List<String>? get tags; // Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt; // Computed fields (from RPC)
  @override
  @JsonKey(name: 'distance_km')
  double? get distanceKm;
  @override
  @JsonKey(name: 'is_saved')
  bool get isSaved;
  @override
  @JsonKey(name: 'relevance_score')
  double? get relevanceScore;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingImplCopyWith<_$ListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ListingFilters _$ListingFiltersFromJson(Map<String, dynamic> json) {
  return _ListingFilters.fromJson(json);
}

/// @nodoc
mixin _$ListingFilters {
  // Search and basic filtering
  String? get searchQuery => throw _privateConstructorUsedError;
  List<ListingType>? get types => throw _privateConstructorUsedError;
  List<UserRole>? get roles =>
      throw _privateConstructorUsedError; // Categories (flexible structure)
  Map<String, List<String>>? get categories =>
      throw _privateConstructorUsedError; // Budget filtering
  double? get minBudget => throw _privateConstructorUsedError;
  double? get maxBudget => throw _privateConstructorUsedError;
  bool? get budgetNegotiable =>
      throw _privateConstructorUsedError; // Location and geography
  double? get userLat => throw _privateConstructorUsedError;
  double? get userLng => throw _privateConstructorUsedError;
  int? get maxDistanceKm => throw _privateConstructorUsedError;
  bool get includeRemote => throw _privateConstructorUsedError;
  String? get locationSearch => throw _privateConstructorUsedError; // Timing
  DateTime? get eventDateFrom => throw _privateConstructorUsedError;
  DateTime? get eventDateTo => throw _privateConstructorUsedError;
  DateTime? get applicationDeadlineFrom =>
      throw _privateConstructorUsedError; // Requirements
  List<String>? get requiredSkills => throw _privateConstructorUsedError;
  List<ExperienceLevel>? get experienceLevels =>
      throw _privateConstructorUsedError;
  int? get minAge => throw _privateConstructorUsedError;
  int? get maxAge => throw _privateConstructorUsedError; // Flags
  bool get urgentOnly => throw _privateConstructorUsedError;
  bool get featuredOnly =>
      throw _privateConstructorUsedError; // Sorting and view
  SortOption get sortBy => throw _privateConstructorUsedError;
  ViewMode get viewMode => throw _privateConstructorUsedError; // Pagination
  int get pageLimit => throw _privateConstructorUsedError;
  int get pageOffset => throw _privateConstructorUsedError;

  /// Serializes this ListingFilters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingFiltersCopyWith<ListingFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingFiltersCopyWith<$Res> {
  factory $ListingFiltersCopyWith(
    ListingFilters value,
    $Res Function(ListingFilters) then,
  ) = _$ListingFiltersCopyWithImpl<$Res, ListingFilters>;
  @useResult
  $Res call({
    String? searchQuery,
    List<ListingType>? types,
    List<UserRole>? roles,
    Map<String, List<String>>? categories,
    double? minBudget,
    double? maxBudget,
    bool? budgetNegotiable,
    double? userLat,
    double? userLng,
    int? maxDistanceKm,
    bool includeRemote,
    String? locationSearch,
    DateTime? eventDateFrom,
    DateTime? eventDateTo,
    DateTime? applicationDeadlineFrom,
    List<String>? requiredSkills,
    List<ExperienceLevel>? experienceLevels,
    int? minAge,
    int? maxAge,
    bool urgentOnly,
    bool featuredOnly,
    SortOption sortBy,
    ViewMode viewMode,
    int pageLimit,
    int pageOffset,
  });
}

/// @nodoc
class _$ListingFiltersCopyWithImpl<$Res, $Val extends ListingFilters>
    implements $ListingFiltersCopyWith<$Res> {
  _$ListingFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = freezed,
    Object? types = freezed,
    Object? roles = freezed,
    Object? categories = freezed,
    Object? minBudget = freezed,
    Object? maxBudget = freezed,
    Object? budgetNegotiable = freezed,
    Object? userLat = freezed,
    Object? userLng = freezed,
    Object? maxDistanceKm = freezed,
    Object? includeRemote = null,
    Object? locationSearch = freezed,
    Object? eventDateFrom = freezed,
    Object? eventDateTo = freezed,
    Object? applicationDeadlineFrom = freezed,
    Object? requiredSkills = freezed,
    Object? experienceLevels = freezed,
    Object? minAge = freezed,
    Object? maxAge = freezed,
    Object? urgentOnly = null,
    Object? featuredOnly = null,
    Object? sortBy = null,
    Object? viewMode = null,
    Object? pageLimit = null,
    Object? pageOffset = null,
  }) {
    return _then(
      _value.copyWith(
            searchQuery: freezed == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String?,
            types: freezed == types
                ? _value.types
                : types // ignore: cast_nullable_to_non_nullable
                      as List<ListingType>?,
            roles: freezed == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<UserRole>?,
            categories: freezed == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>?,
            minBudget: freezed == minBudget
                ? _value.minBudget
                : minBudget // ignore: cast_nullable_to_non_nullable
                      as double?,
            maxBudget: freezed == maxBudget
                ? _value.maxBudget
                : maxBudget // ignore: cast_nullable_to_non_nullable
                      as double?,
            budgetNegotiable: freezed == budgetNegotiable
                ? _value.budgetNegotiable
                : budgetNegotiable // ignore: cast_nullable_to_non_nullable
                      as bool?,
            userLat: freezed == userLat
                ? _value.userLat
                : userLat // ignore: cast_nullable_to_non_nullable
                      as double?,
            userLng: freezed == userLng
                ? _value.userLng
                : userLng // ignore: cast_nullable_to_non_nullable
                      as double?,
            maxDistanceKm: freezed == maxDistanceKm
                ? _value.maxDistanceKm
                : maxDistanceKm // ignore: cast_nullable_to_non_nullable
                      as int?,
            includeRemote: null == includeRemote
                ? _value.includeRemote
                : includeRemote // ignore: cast_nullable_to_non_nullable
                      as bool,
            locationSearch: freezed == locationSearch
                ? _value.locationSearch
                : locationSearch // ignore: cast_nullable_to_non_nullable
                      as String?,
            eventDateFrom: freezed == eventDateFrom
                ? _value.eventDateFrom
                : eventDateFrom // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            eventDateTo: freezed == eventDateTo
                ? _value.eventDateTo
                : eventDateTo // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            applicationDeadlineFrom: freezed == applicationDeadlineFrom
                ? _value.applicationDeadlineFrom
                : applicationDeadlineFrom // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            requiredSkills: freezed == requiredSkills
                ? _value.requiredSkills
                : requiredSkills // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            experienceLevels: freezed == experienceLevels
                ? _value.experienceLevels
                : experienceLevels // ignore: cast_nullable_to_non_nullable
                      as List<ExperienceLevel>?,
            minAge: freezed == minAge
                ? _value.minAge
                : minAge // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxAge: freezed == maxAge
                ? _value.maxAge
                : maxAge // ignore: cast_nullable_to_non_nullable
                      as int?,
            urgentOnly: null == urgentOnly
                ? _value.urgentOnly
                : urgentOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            featuredOnly: null == featuredOnly
                ? _value.featuredOnly
                : featuredOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortBy: null == sortBy
                ? _value.sortBy
                : sortBy // ignore: cast_nullable_to_non_nullable
                      as SortOption,
            viewMode: null == viewMode
                ? _value.viewMode
                : viewMode // ignore: cast_nullable_to_non_nullable
                      as ViewMode,
            pageLimit: null == pageLimit
                ? _value.pageLimit
                : pageLimit // ignore: cast_nullable_to_non_nullable
                      as int,
            pageOffset: null == pageOffset
                ? _value.pageOffset
                : pageOffset // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingFiltersImplCopyWith<$Res>
    implements $ListingFiltersCopyWith<$Res> {
  factory _$$ListingFiltersImplCopyWith(
    _$ListingFiltersImpl value,
    $Res Function(_$ListingFiltersImpl) then,
  ) = __$$ListingFiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? searchQuery,
    List<ListingType>? types,
    List<UserRole>? roles,
    Map<String, List<String>>? categories,
    double? minBudget,
    double? maxBudget,
    bool? budgetNegotiable,
    double? userLat,
    double? userLng,
    int? maxDistanceKm,
    bool includeRemote,
    String? locationSearch,
    DateTime? eventDateFrom,
    DateTime? eventDateTo,
    DateTime? applicationDeadlineFrom,
    List<String>? requiredSkills,
    List<ExperienceLevel>? experienceLevels,
    int? minAge,
    int? maxAge,
    bool urgentOnly,
    bool featuredOnly,
    SortOption sortBy,
    ViewMode viewMode,
    int pageLimit,
    int pageOffset,
  });
}

/// @nodoc
class __$$ListingFiltersImplCopyWithImpl<$Res>
    extends _$ListingFiltersCopyWithImpl<$Res, _$ListingFiltersImpl>
    implements _$$ListingFiltersImplCopyWith<$Res> {
  __$$ListingFiltersImplCopyWithImpl(
    _$ListingFiltersImpl _value,
    $Res Function(_$ListingFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListingFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = freezed,
    Object? types = freezed,
    Object? roles = freezed,
    Object? categories = freezed,
    Object? minBudget = freezed,
    Object? maxBudget = freezed,
    Object? budgetNegotiable = freezed,
    Object? userLat = freezed,
    Object? userLng = freezed,
    Object? maxDistanceKm = freezed,
    Object? includeRemote = null,
    Object? locationSearch = freezed,
    Object? eventDateFrom = freezed,
    Object? eventDateTo = freezed,
    Object? applicationDeadlineFrom = freezed,
    Object? requiredSkills = freezed,
    Object? experienceLevels = freezed,
    Object? minAge = freezed,
    Object? maxAge = freezed,
    Object? urgentOnly = null,
    Object? featuredOnly = null,
    Object? sortBy = null,
    Object? viewMode = null,
    Object? pageLimit = null,
    Object? pageOffset = null,
  }) {
    return _then(
      _$ListingFiltersImpl(
        searchQuery: freezed == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
        types: freezed == types
            ? _value._types
            : types // ignore: cast_nullable_to_non_nullable
                  as List<ListingType>?,
        roles: freezed == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<UserRole>?,
        categories: freezed == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>?,
        minBudget: freezed == minBudget
            ? _value.minBudget
            : minBudget // ignore: cast_nullable_to_non_nullable
                  as double?,
        maxBudget: freezed == maxBudget
            ? _value.maxBudget
            : maxBudget // ignore: cast_nullable_to_non_nullable
                  as double?,
        budgetNegotiable: freezed == budgetNegotiable
            ? _value.budgetNegotiable
            : budgetNegotiable // ignore: cast_nullable_to_non_nullable
                  as bool?,
        userLat: freezed == userLat
            ? _value.userLat
            : userLat // ignore: cast_nullable_to_non_nullable
                  as double?,
        userLng: freezed == userLng
            ? _value.userLng
            : userLng // ignore: cast_nullable_to_non_nullable
                  as double?,
        maxDistanceKm: freezed == maxDistanceKm
            ? _value.maxDistanceKm
            : maxDistanceKm // ignore: cast_nullable_to_non_nullable
                  as int?,
        includeRemote: null == includeRemote
            ? _value.includeRemote
            : includeRemote // ignore: cast_nullable_to_non_nullable
                  as bool,
        locationSearch: freezed == locationSearch
            ? _value.locationSearch
            : locationSearch // ignore: cast_nullable_to_non_nullable
                  as String?,
        eventDateFrom: freezed == eventDateFrom
            ? _value.eventDateFrom
            : eventDateFrom // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        eventDateTo: freezed == eventDateTo
            ? _value.eventDateTo
            : eventDateTo // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        applicationDeadlineFrom: freezed == applicationDeadlineFrom
            ? _value.applicationDeadlineFrom
            : applicationDeadlineFrom // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        requiredSkills: freezed == requiredSkills
            ? _value._requiredSkills
            : requiredSkills // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        experienceLevels: freezed == experienceLevels
            ? _value._experienceLevels
            : experienceLevels // ignore: cast_nullable_to_non_nullable
                  as List<ExperienceLevel>?,
        minAge: freezed == minAge
            ? _value.minAge
            : minAge // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxAge: freezed == maxAge
            ? _value.maxAge
            : maxAge // ignore: cast_nullable_to_non_nullable
                  as int?,
        urgentOnly: null == urgentOnly
            ? _value.urgentOnly
            : urgentOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        featuredOnly: null == featuredOnly
            ? _value.featuredOnly
            : featuredOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortBy: null == sortBy
            ? _value.sortBy
            : sortBy // ignore: cast_nullable_to_non_nullable
                  as SortOption,
        viewMode: null == viewMode
            ? _value.viewMode
            : viewMode // ignore: cast_nullable_to_non_nullable
                  as ViewMode,
        pageLimit: null == pageLimit
            ? _value.pageLimit
            : pageLimit // ignore: cast_nullable_to_non_nullable
                  as int,
        pageOffset: null == pageOffset
            ? _value.pageOffset
            : pageOffset // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingFiltersImpl implements _ListingFilters {
  const _$ListingFiltersImpl({
    this.searchQuery,
    final List<ListingType>? types,
    final List<UserRole>? roles,
    final Map<String, List<String>>? categories,
    this.minBudget,
    this.maxBudget,
    this.budgetNegotiable,
    this.userLat,
    this.userLng,
    this.maxDistanceKm,
    this.includeRemote = true,
    this.locationSearch,
    this.eventDateFrom,
    this.eventDateTo,
    this.applicationDeadlineFrom,
    final List<String>? requiredSkills,
    final List<ExperienceLevel>? experienceLevels,
    this.minAge,
    this.maxAge,
    this.urgentOnly = false,
    this.featuredOnly = false,
    this.sortBy = SortOption.newest,
    this.viewMode = ViewMode.list,
    this.pageLimit = 20,
    this.pageOffset = 0,
  }) : _types = types,
       _roles = roles,
       _categories = categories,
       _requiredSkills = requiredSkills,
       _experienceLevels = experienceLevels;

  factory _$ListingFiltersImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingFiltersImplFromJson(json);

  // Search and basic filtering
  @override
  final String? searchQuery;
  final List<ListingType>? _types;
  @override
  List<ListingType>? get types {
    final value = _types;
    if (value == null) return null;
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserRole>? _roles;
  @override
  List<UserRole>? get roles {
    final value = _roles;
    if (value == null) return null;
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Categories (flexible structure)
  final Map<String, List<String>>? _categories;
  // Categories (flexible structure)
  @override
  Map<String, List<String>>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableMapView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // Budget filtering
  @override
  final double? minBudget;
  @override
  final double? maxBudget;
  @override
  final bool? budgetNegotiable;
  // Location and geography
  @override
  final double? userLat;
  @override
  final double? userLng;
  @override
  final int? maxDistanceKm;
  @override
  @JsonKey()
  final bool includeRemote;
  @override
  final String? locationSearch;
  // Timing
  @override
  final DateTime? eventDateFrom;
  @override
  final DateTime? eventDateTo;
  @override
  final DateTime? applicationDeadlineFrom;
  // Requirements
  final List<String>? _requiredSkills;
  // Requirements
  @override
  List<String>? get requiredSkills {
    final value = _requiredSkills;
    if (value == null) return null;
    if (_requiredSkills is EqualUnmodifiableListView) return _requiredSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExperienceLevel>? _experienceLevels;
  @override
  List<ExperienceLevel>? get experienceLevels {
    final value = _experienceLevels;
    if (value == null) return null;
    if (_experienceLevels is EqualUnmodifiableListView)
      return _experienceLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? minAge;
  @override
  final int? maxAge;
  // Flags
  @override
  @JsonKey()
  final bool urgentOnly;
  @override
  @JsonKey()
  final bool featuredOnly;
  // Sorting and view
  @override
  @JsonKey()
  final SortOption sortBy;
  @override
  @JsonKey()
  final ViewMode viewMode;
  // Pagination
  @override
  @JsonKey()
  final int pageLimit;
  @override
  @JsonKey()
  final int pageOffset;

  @override
  String toString() {
    return 'ListingFilters(searchQuery: $searchQuery, types: $types, roles: $roles, categories: $categories, minBudget: $minBudget, maxBudget: $maxBudget, budgetNegotiable: $budgetNegotiable, userLat: $userLat, userLng: $userLng, maxDistanceKm: $maxDistanceKm, includeRemote: $includeRemote, locationSearch: $locationSearch, eventDateFrom: $eventDateFrom, eventDateTo: $eventDateTo, applicationDeadlineFrom: $applicationDeadlineFrom, requiredSkills: $requiredSkills, experienceLevels: $experienceLevels, minAge: $minAge, maxAge: $maxAge, urgentOnly: $urgentOnly, featuredOnly: $featuredOnly, sortBy: $sortBy, viewMode: $viewMode, pageLimit: $pageLimit, pageOffset: $pageOffset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingFiltersImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.minBudget, minBudget) ||
                other.minBudget == minBudget) &&
            (identical(other.maxBudget, maxBudget) ||
                other.maxBudget == maxBudget) &&
            (identical(other.budgetNegotiable, budgetNegotiable) ||
                other.budgetNegotiable == budgetNegotiable) &&
            (identical(other.userLat, userLat) || other.userLat == userLat) &&
            (identical(other.userLng, userLng) || other.userLng == userLng) &&
            (identical(other.maxDistanceKm, maxDistanceKm) ||
                other.maxDistanceKm == maxDistanceKm) &&
            (identical(other.includeRemote, includeRemote) ||
                other.includeRemote == includeRemote) &&
            (identical(other.locationSearch, locationSearch) ||
                other.locationSearch == locationSearch) &&
            (identical(other.eventDateFrom, eventDateFrom) ||
                other.eventDateFrom == eventDateFrom) &&
            (identical(other.eventDateTo, eventDateTo) ||
                other.eventDateTo == eventDateTo) &&
            (identical(
                  other.applicationDeadlineFrom,
                  applicationDeadlineFrom,
                ) ||
                other.applicationDeadlineFrom == applicationDeadlineFrom) &&
            const DeepCollectionEquality().equals(
              other._requiredSkills,
              _requiredSkills,
            ) &&
            const DeepCollectionEquality().equals(
              other._experienceLevels,
              _experienceLevels,
            ) &&
            (identical(other.minAge, minAge) || other.minAge == minAge) &&
            (identical(other.maxAge, maxAge) || other.maxAge == maxAge) &&
            (identical(other.urgentOnly, urgentOnly) ||
                other.urgentOnly == urgentOnly) &&
            (identical(other.featuredOnly, featuredOnly) ||
                other.featuredOnly == featuredOnly) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.viewMode, viewMode) ||
                other.viewMode == viewMode) &&
            (identical(other.pageLimit, pageLimit) ||
                other.pageLimit == pageLimit) &&
            (identical(other.pageOffset, pageOffset) ||
                other.pageOffset == pageOffset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    searchQuery,
    const DeepCollectionEquality().hash(_types),
    const DeepCollectionEquality().hash(_roles),
    const DeepCollectionEquality().hash(_categories),
    minBudget,
    maxBudget,
    budgetNegotiable,
    userLat,
    userLng,
    maxDistanceKm,
    includeRemote,
    locationSearch,
    eventDateFrom,
    eventDateTo,
    applicationDeadlineFrom,
    const DeepCollectionEquality().hash(_requiredSkills),
    const DeepCollectionEquality().hash(_experienceLevels),
    minAge,
    maxAge,
    urgentOnly,
    featuredOnly,
    sortBy,
    viewMode,
    pageLimit,
    pageOffset,
  ]);

  /// Create a copy of ListingFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingFiltersImplCopyWith<_$ListingFiltersImpl> get copyWith =>
      __$$ListingFiltersImplCopyWithImpl<_$ListingFiltersImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingFiltersImplToJson(this);
  }
}

abstract class _ListingFilters implements ListingFilters {
  const factory _ListingFilters({
    final String? searchQuery,
    final List<ListingType>? types,
    final List<UserRole>? roles,
    final Map<String, List<String>>? categories,
    final double? minBudget,
    final double? maxBudget,
    final bool? budgetNegotiable,
    final double? userLat,
    final double? userLng,
    final int? maxDistanceKm,
    final bool includeRemote,
    final String? locationSearch,
    final DateTime? eventDateFrom,
    final DateTime? eventDateTo,
    final DateTime? applicationDeadlineFrom,
    final List<String>? requiredSkills,
    final List<ExperienceLevel>? experienceLevels,
    final int? minAge,
    final int? maxAge,
    final bool urgentOnly,
    final bool featuredOnly,
    final SortOption sortBy,
    final ViewMode viewMode,
    final int pageLimit,
    final int pageOffset,
  }) = _$ListingFiltersImpl;

  factory _ListingFilters.fromJson(Map<String, dynamic> json) =
      _$ListingFiltersImpl.fromJson;

  // Search and basic filtering
  @override
  String? get searchQuery;
  @override
  List<ListingType>? get types;
  @override
  List<UserRole>? get roles; // Categories (flexible structure)
  @override
  Map<String, List<String>>? get categories; // Budget filtering
  @override
  double? get minBudget;
  @override
  double? get maxBudget;
  @override
  bool? get budgetNegotiable; // Location and geography
  @override
  double? get userLat;
  @override
  double? get userLng;
  @override
  int? get maxDistanceKm;
  @override
  bool get includeRemote;
  @override
  String? get locationSearch; // Timing
  @override
  DateTime? get eventDateFrom;
  @override
  DateTime? get eventDateTo;
  @override
  DateTime? get applicationDeadlineFrom; // Requirements
  @override
  List<String>? get requiredSkills;
  @override
  List<ExperienceLevel>? get experienceLevels;
  @override
  int? get minAge;
  @override
  int? get maxAge; // Flags
  @override
  bool get urgentOnly;
  @override
  bool get featuredOnly; // Sorting and view
  @override
  SortOption get sortBy;
  @override
  ViewMode get viewMode; // Pagination
  @override
  int get pageLimit;
  @override
  int get pageOffset;

  /// Create a copy of ListingFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingFiltersImplCopyWith<_$ListingFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ListingSearchResult _$ListingSearchResultFromJson(Map<String, dynamic> json) {
  return _ListingSearchResult.fromJson(json);
}

/// @nodoc
mixin _$ListingSearchResult {
  List<Listing> get listings => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;

  /// Serializes this ListingSearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingSearchResultCopyWith<ListingSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingSearchResultCopyWith<$Res> {
  factory $ListingSearchResultCopyWith(
    ListingSearchResult value,
    $Res Function(ListingSearchResult) then,
  ) = _$ListingSearchResultCopyWithImpl<$Res, ListingSearchResult>;
  @useResult
  $Res call({
    List<Listing> listings,
    int totalCount,
    bool hasMore,
    int currentPage,
  });
}

/// @nodoc
class _$ListingSearchResultCopyWithImpl<$Res, $Val extends ListingSearchResult>
    implements $ListingSearchResultCopyWith<$Res> {
  _$ListingSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listings = null,
    Object? totalCount = null,
    Object? hasMore = null,
    Object? currentPage = null,
  }) {
    return _then(
      _value.copyWith(
            listings: null == listings
                ? _value.listings
                : listings // ignore: cast_nullable_to_non_nullable
                      as List<Listing>,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingSearchResultImplCopyWith<$Res>
    implements $ListingSearchResultCopyWith<$Res> {
  factory _$$ListingSearchResultImplCopyWith(
    _$ListingSearchResultImpl value,
    $Res Function(_$ListingSearchResultImpl) then,
  ) = __$$ListingSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Listing> listings,
    int totalCount,
    bool hasMore,
    int currentPage,
  });
}

/// @nodoc
class __$$ListingSearchResultImplCopyWithImpl<$Res>
    extends _$ListingSearchResultCopyWithImpl<$Res, _$ListingSearchResultImpl>
    implements _$$ListingSearchResultImplCopyWith<$Res> {
  __$$ListingSearchResultImplCopyWithImpl(
    _$ListingSearchResultImpl _value,
    $Res Function(_$ListingSearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListingSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listings = null,
    Object? totalCount = null,
    Object? hasMore = null,
    Object? currentPage = null,
  }) {
    return _then(
      _$ListingSearchResultImpl(
        listings: null == listings
            ? _value._listings
            : listings // ignore: cast_nullable_to_non_nullable
                  as List<Listing>,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingSearchResultImpl implements _ListingSearchResult {
  const _$ListingSearchResultImpl({
    required final List<Listing> listings,
    required this.totalCount,
    required this.hasMore,
    required this.currentPage,
  }) : _listings = listings;

  factory _$ListingSearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingSearchResultImplFromJson(json);

  final List<Listing> _listings;
  @override
  List<Listing> get listings {
    if (_listings is EqualUnmodifiableListView) return _listings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listings);
  }

  @override
  final int totalCount;
  @override
  final bool hasMore;
  @override
  final int currentPage;

  @override
  String toString() {
    return 'ListingSearchResult(listings: $listings, totalCount: $totalCount, hasMore: $hasMore, currentPage: $currentPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingSearchResultImpl &&
            const DeepCollectionEquality().equals(other._listings, _listings) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_listings),
    totalCount,
    hasMore,
    currentPage,
  );

  /// Create a copy of ListingSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingSearchResultImplCopyWith<_$ListingSearchResultImpl> get copyWith =>
      __$$ListingSearchResultImplCopyWithImpl<_$ListingSearchResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingSearchResultImplToJson(this);
  }
}

abstract class _ListingSearchResult implements ListingSearchResult {
  const factory _ListingSearchResult({
    required final List<Listing> listings,
    required final int totalCount,
    required final bool hasMore,
    required final int currentPage,
  }) = _$ListingSearchResultImpl;

  factory _ListingSearchResult.fromJson(Map<String, dynamic> json) =
      _$ListingSearchResultImpl.fromJson;

  @override
  List<Listing> get listings;
  @override
  int get totalCount;
  @override
  bool get hasMore;
  @override
  int get currentPage;

  /// Create a copy of ListingSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingSearchResultImplCopyWith<_$ListingSearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

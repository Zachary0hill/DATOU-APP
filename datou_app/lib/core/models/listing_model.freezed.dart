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
  String get creatorId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ListingType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'required_role')
  UserRole? get requiredRole => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_negotiable')
  bool get isNegotiable => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_date')
  DateTime? get eventDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_duration')
  int? get eventDurationHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'application_deadline')
  DateTime? get applicationDeadline => throw _privateConstructorUsedError;
  @JsonKey(name: 'required_skills')
  List<String>? get requiredSkills => throw _privateConstructorUsedError;
  @JsonKey(name: 'preferred_experience')
  int? get preferredExperience => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_method')
  String get contactMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  ListingStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_urgent')
  bool get isUrgent => throw _privateConstructorUsedError;
  @JsonKey(name: 'view_count')
  int get viewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'application_count')
  int get applicationCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;

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
    double budget,
    @JsonKey(name: 'is_negotiable') bool isNegotiable,
    String location,
    @JsonKey(name: 'event_date') DateTime? eventDate,
    @JsonKey(name: 'event_duration') int? eventDurationHours,
    @JsonKey(name: 'application_deadline') DateTime? applicationDeadline,
    @JsonKey(name: 'required_skills') List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') int? preferredExperience,
    @JsonKey(name: 'contact_method') String contactMethod,
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
    ListingStatus status,
    @JsonKey(name: 'is_urgent') bool isUrgent,
    @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'application_count') int applicationCount,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
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
    Object? budget = null,
    Object? isNegotiable = null,
    Object? location = null,
    Object? eventDate = freezed,
    Object? eventDurationHours = freezed,
    Object? applicationDeadline = freezed,
    Object? requiredSkills = freezed,
    Object? preferredExperience = freezed,
    Object? contactMethod = null,
    Object? imageUrls = freezed,
    Object? status = null,
    Object? isUrgent = null,
    Object? viewCount = null,
    Object? applicationCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? expiresAt = freezed,
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
            budget: null == budget
                ? _value.budget
                : budget // ignore: cast_nullable_to_non_nullable
                      as double,
            isNegotiable: null == isNegotiable
                ? _value.isNegotiable
                : isNegotiable // ignore: cast_nullable_to_non_nullable
                      as bool,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
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
                      as int?,
            contactMethod: null == contactMethod
                ? _value.contactMethod
                : contactMethod // ignore: cast_nullable_to_non_nullable
                      as String,
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
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            applicationCount: null == applicationCount
                ? _value.applicationCount
                : applicationCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
    double budget,
    @JsonKey(name: 'is_negotiable') bool isNegotiable,
    String location,
    @JsonKey(name: 'event_date') DateTime? eventDate,
    @JsonKey(name: 'event_duration') int? eventDurationHours,
    @JsonKey(name: 'application_deadline') DateTime? applicationDeadline,
    @JsonKey(name: 'required_skills') List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') int? preferredExperience,
    @JsonKey(name: 'contact_method') String contactMethod,
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
    ListingStatus status,
    @JsonKey(name: 'is_urgent') bool isUrgent,
    @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'application_count') int applicationCount,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
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
    Object? budget = null,
    Object? isNegotiable = null,
    Object? location = null,
    Object? eventDate = freezed,
    Object? eventDurationHours = freezed,
    Object? applicationDeadline = freezed,
    Object? requiredSkills = freezed,
    Object? preferredExperience = freezed,
    Object? contactMethod = null,
    Object? imageUrls = freezed,
    Object? status = null,
    Object? isUrgent = null,
    Object? viewCount = null,
    Object? applicationCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? expiresAt = freezed,
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
        budget: null == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as double,
        isNegotiable: null == isNegotiable
            ? _value.isNegotiable
            : isNegotiable // ignore: cast_nullable_to_non_nullable
                  as bool,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
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
                  as int?,
        contactMethod: null == contactMethod
            ? _value.contactMethod
            : contactMethod // ignore: cast_nullable_to_non_nullable
                  as String,
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
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        applicationCount: null == applicationCount
            ? _value.applicationCount
            : applicationCount // ignore: cast_nullable_to_non_nullable
                  as int,
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
    required this.budget,
    @JsonKey(name: 'is_negotiable') this.isNegotiable = true,
    required this.location,
    @JsonKey(name: 'event_date') this.eventDate,
    @JsonKey(name: 'event_duration') this.eventDurationHours,
    @JsonKey(name: 'application_deadline') this.applicationDeadline,
    @JsonKey(name: 'required_skills') final List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') this.preferredExperience,
    @JsonKey(name: 'contact_method') this.contactMethod = 'in_app',
    @JsonKey(name: 'image_urls') final List<String>? imageUrls,
    this.status = ListingStatus.draft,
    @JsonKey(name: 'is_urgent') this.isUrgent = false,
    @JsonKey(name: 'view_count') this.viewCount = 0,
    @JsonKey(name: 'application_count') this.applicationCount = 0,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    @JsonKey(name: 'expires_at') this.expiresAt,
  }) : _requiredSkills = requiredSkills,
       _imageUrls = imageUrls;

  factory _$ListingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'creator_id')
  final String creatorId;
  @override
  final String title;
  @override
  final String description;
  @override
  final ListingType type;
  @override
  @JsonKey(name: 'required_role')
  final UserRole? requiredRole;
  @override
  final double budget;
  @override
  @JsonKey(name: 'is_negotiable')
  final bool isNegotiable;
  @override
  final String location;
  @override
  @JsonKey(name: 'event_date')
  final DateTime? eventDate;
  @override
  @JsonKey(name: 'event_duration')
  final int? eventDurationHours;
  @override
  @JsonKey(name: 'application_deadline')
  final DateTime? applicationDeadline;
  final List<String>? _requiredSkills;
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
  final int? preferredExperience;
  @override
  @JsonKey(name: 'contact_method')
  final String contactMethod;
  final List<String>? _imageUrls;
  @override
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final ListingStatus status;
  @override
  @JsonKey(name: 'is_urgent')
  final bool isUrgent;
  @override
  @JsonKey(name: 'view_count')
  final int viewCount;
  @override
  @JsonKey(name: 'application_count')
  final int applicationCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'Listing(id: $id, creatorId: $creatorId, title: $title, description: $description, type: $type, requiredRole: $requiredRole, budget: $budget, isNegotiable: $isNegotiable, location: $location, eventDate: $eventDate, eventDurationHours: $eventDurationHours, applicationDeadline: $applicationDeadline, requiredSkills: $requiredSkills, preferredExperience: $preferredExperience, contactMethod: $contactMethod, imageUrls: $imageUrls, status: $status, isUrgent: $isUrgent, viewCount: $viewCount, applicationCount: $applicationCount, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt)';
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
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.isNegotiable, isNegotiable) ||
                other.isNegotiable == isNegotiable) &&
            (identical(other.location, location) ||
                other.location == location) &&
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
            (identical(other.contactMethod, contactMethod) ||
                other.contactMethod == contactMethod) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.applicationCount, applicationCount) ||
                other.applicationCount == applicationCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
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
    budget,
    isNegotiable,
    location,
    eventDate,
    eventDurationHours,
    applicationDeadline,
    const DeepCollectionEquality().hash(_requiredSkills),
    preferredExperience,
    contactMethod,
    const DeepCollectionEquality().hash(_imageUrls),
    status,
    isUrgent,
    viewCount,
    applicationCount,
    createdAt,
    updatedAt,
    expiresAt,
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
    required final double budget,
    @JsonKey(name: 'is_negotiable') final bool isNegotiable,
    required final String location,
    @JsonKey(name: 'event_date') final DateTime? eventDate,
    @JsonKey(name: 'event_duration') final int? eventDurationHours,
    @JsonKey(name: 'application_deadline') final DateTime? applicationDeadline,
    @JsonKey(name: 'required_skills') final List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') final int? preferredExperience,
    @JsonKey(name: 'contact_method') final String contactMethod,
    @JsonKey(name: 'image_urls') final List<String>? imageUrls,
    final ListingStatus status,
    @JsonKey(name: 'is_urgent') final bool isUrgent,
    @JsonKey(name: 'view_count') final int viewCount,
    @JsonKey(name: 'application_count') final int applicationCount,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    @JsonKey(name: 'expires_at') final DateTime? expiresAt,
  }) = _$ListingImpl;

  factory _Listing.fromJson(Map<String, dynamic> json) = _$ListingImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'creator_id')
  String get creatorId;
  @override
  String get title;
  @override
  String get description;
  @override
  ListingType get type;
  @override
  @JsonKey(name: 'required_role')
  UserRole? get requiredRole;
  @override
  double get budget;
  @override
  @JsonKey(name: 'is_negotiable')
  bool get isNegotiable;
  @override
  String get location;
  @override
  @JsonKey(name: 'event_date')
  DateTime? get eventDate;
  @override
  @JsonKey(name: 'event_duration')
  int? get eventDurationHours;
  @override
  @JsonKey(name: 'application_deadline')
  DateTime? get applicationDeadline;
  @override
  @JsonKey(name: 'required_skills')
  List<String>? get requiredSkills;
  @override
  @JsonKey(name: 'preferred_experience')
  int? get preferredExperience;
  @override
  @JsonKey(name: 'contact_method')
  String get contactMethod;
  @override
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls;
  @override
  ListingStatus get status;
  @override
  @JsonKey(name: 'is_urgent')
  bool get isUrgent;
  @override
  @JsonKey(name: 'view_count')
  int get viewCount;
  @override
  @JsonKey(name: 'application_count')
  int get applicationCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingImplCopyWith<_$ListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

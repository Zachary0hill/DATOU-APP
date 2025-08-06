// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_image_url')
  String? get coverImageUrl => throw _privateConstructorUsedError;
  UserRole? get role => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'travel_radius')
  int? get travelRadius => throw _privateConstructorUsedError;
  @JsonKey(name: 'hourly_rate')
  double? get hourlyRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_rate')
  double? get dayRate => throw _privateConstructorUsedError;
  List<String>? get skills => throw _privateConstructorUsedError;
  List<String>? get equipment => throw _privateConstructorUsedError;
  @JsonKey(name: 'years_experience')
  int? get yearsExperience => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  @JsonKey(name: 'instagram_handle')
  String? get instagramHandle => throw _privateConstructorUsedError;
  @JsonKey(name: 'portfolio_images')
  List<String>? get portfolioImages => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_jobs')
  int get totalJobs => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'full_name') String? fullName,
    String? username,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    UserRole? role,
    String? location,
    @JsonKey(name: 'travel_radius') int? travelRadius,
    @JsonKey(name: 'hourly_rate') double? hourlyRate,
    @JsonKey(name: 'day_rate') double? dayRate,
    List<String>? skills,
    List<String>? equipment,
    @JsonKey(name: 'years_experience') int? yearsExperience,
    String? website,
    @JsonKey(name: 'instagram_handle') String? instagramHandle,
    @JsonKey(name: 'portfolio_images') List<String>? portfolioImages,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'is_available') bool isAvailable,
    double rating,
    @JsonKey(name: 'total_jobs') int totalJobs,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = freezed,
    Object? username = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? role = freezed,
    Object? location = freezed,
    Object? travelRadius = freezed,
    Object? hourlyRate = freezed,
    Object? dayRate = freezed,
    Object? skills = freezed,
    Object? equipment = freezed,
    Object? yearsExperience = freezed,
    Object? website = freezed,
    Object? instagramHandle = freezed,
    Object? portfolioImages = freezed,
    Object? isVerified = null,
    Object? isAvailable = null,
    Object? rating = null,
    Object? totalJobs = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverImageUrl: freezed == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as UserRole?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            travelRadius: freezed == travelRadius
                ? _value.travelRadius
                : travelRadius // ignore: cast_nullable_to_non_nullable
                      as int?,
            hourlyRate: freezed == hourlyRate
                ? _value.hourlyRate
                : hourlyRate // ignore: cast_nullable_to_non_nullable
                      as double?,
            dayRate: freezed == dayRate
                ? _value.dayRate
                : dayRate // ignore: cast_nullable_to_non_nullable
                      as double?,
            skills: freezed == skills
                ? _value.skills
                : skills // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            equipment: freezed == equipment
                ? _value.equipment
                : equipment // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            yearsExperience: freezed == yearsExperience
                ? _value.yearsExperience
                : yearsExperience // ignore: cast_nullable_to_non_nullable
                      as int?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            instagramHandle: freezed == instagramHandle
                ? _value.instagramHandle
                : instagramHandle // ignore: cast_nullable_to_non_nullable
                      as String?,
            portfolioImages: freezed == portfolioImages
                ? _value.portfolioImages
                : portfolioImages // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            totalJobs: null == totalJobs
                ? _value.totalJobs
                : totalJobs // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
    _$ProfileImpl value,
    $Res Function(_$ProfileImpl) then,
  ) = __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'full_name') String? fullName,
    String? username,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    UserRole? role,
    String? location,
    @JsonKey(name: 'travel_radius') int? travelRadius,
    @JsonKey(name: 'hourly_rate') double? hourlyRate,
    @JsonKey(name: 'day_rate') double? dayRate,
    List<String>? skills,
    List<String>? equipment,
    @JsonKey(name: 'years_experience') int? yearsExperience,
    String? website,
    @JsonKey(name: 'instagram_handle') String? instagramHandle,
    @JsonKey(name: 'portfolio_images') List<String>? portfolioImages,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'is_available') bool isAvailable,
    double rating,
    @JsonKey(name: 'total_jobs') int totalJobs,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
    _$ProfileImpl _value,
    $Res Function(_$ProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = freezed,
    Object? username = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? role = freezed,
    Object? location = freezed,
    Object? travelRadius = freezed,
    Object? hourlyRate = freezed,
    Object? dayRate = freezed,
    Object? skills = freezed,
    Object? equipment = freezed,
    Object? yearsExperience = freezed,
    Object? website = freezed,
    Object? instagramHandle = freezed,
    Object? portfolioImages = freezed,
    Object? isVerified = null,
    Object? isAvailable = null,
    Object? rating = null,
    Object? totalJobs = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: freezed == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverImageUrl: freezed == coverImageUrl
            ? _value.coverImageUrl
            : coverImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as UserRole?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        travelRadius: freezed == travelRadius
            ? _value.travelRadius
            : travelRadius // ignore: cast_nullable_to_non_nullable
                  as int?,
        hourlyRate: freezed == hourlyRate
            ? _value.hourlyRate
            : hourlyRate // ignore: cast_nullable_to_non_nullable
                  as double?,
        dayRate: freezed == dayRate
            ? _value.dayRate
            : dayRate // ignore: cast_nullable_to_non_nullable
                  as double?,
        skills: freezed == skills
            ? _value._skills
            : skills // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        equipment: freezed == equipment
            ? _value._equipment
            : equipment // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        yearsExperience: freezed == yearsExperience
            ? _value.yearsExperience
            : yearsExperience // ignore: cast_nullable_to_non_nullable
                  as int?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        instagramHandle: freezed == instagramHandle
            ? _value.instagramHandle
            : instagramHandle // ignore: cast_nullable_to_non_nullable
                  as String?,
        portfolioImages: freezed == portfolioImages
            ? _value._portfolioImages
            : portfolioImages // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        totalJobs: null == totalJobs
            ? _value.totalJobs
            : totalJobs // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'full_name') this.fullName,
    this.username,
    this.bio,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'cover_image_url') this.coverImageUrl,
    this.role,
    this.location,
    @JsonKey(name: 'travel_radius') this.travelRadius,
    @JsonKey(name: 'hourly_rate') this.hourlyRate,
    @JsonKey(name: 'day_rate') this.dayRate,
    final List<String>? skills,
    final List<String>? equipment,
    @JsonKey(name: 'years_experience') this.yearsExperience,
    this.website,
    @JsonKey(name: 'instagram_handle') this.instagramHandle,
    @JsonKey(name: 'portfolio_images') final List<String>? portfolioImages,
    @JsonKey(name: 'is_verified') this.isVerified = false,
    @JsonKey(name: 'is_available') this.isAvailable = true,
    this.rating = 0.0,
    @JsonKey(name: 'total_jobs') this.totalJobs = 0,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : _skills = skills,
       _equipment = equipment,
       _portfolioImages = portfolioImages;

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  final String? username;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @override
  final UserRole? role;
  @override
  final String? location;
  @override
  @JsonKey(name: 'travel_radius')
  final int? travelRadius;
  @override
  @JsonKey(name: 'hourly_rate')
  final double? hourlyRate;
  @override
  @JsonKey(name: 'day_rate')
  final double? dayRate;
  final List<String>? _skills;
  @override
  List<String>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _equipment;
  @override
  List<String>? get equipment {
    final value = _equipment;
    if (value == null) return null;
    if (_equipment is EqualUnmodifiableListView) return _equipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'years_experience')
  final int? yearsExperience;
  @override
  final String? website;
  @override
  @JsonKey(name: 'instagram_handle')
  final String? instagramHandle;
  final List<String>? _portfolioImages;
  @override
  @JsonKey(name: 'portfolio_images')
  List<String>? get portfolioImages {
    final value = _portfolioImages;
    if (value == null) return null;
    if (_portfolioImages is EqualUnmodifiableListView) return _portfolioImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(name: 'total_jobs')
  final int totalJobs;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Profile(id: $id, userId: $userId, fullName: $fullName, username: $username, bio: $bio, avatarUrl: $avatarUrl, coverImageUrl: $coverImageUrl, role: $role, location: $location, travelRadius: $travelRadius, hourlyRate: $hourlyRate, dayRate: $dayRate, skills: $skills, equipment: $equipment, yearsExperience: $yearsExperience, website: $website, instagramHandle: $instagramHandle, portfolioImages: $portfolioImages, isVerified: $isVerified, isAvailable: $isAvailable, rating: $rating, totalJobs: $totalJobs, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.travelRadius, travelRadius) ||
                other.travelRadius == travelRadius) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.dayRate, dayRate) || other.dayRate == dayRate) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality().equals(
              other._equipment,
              _equipment,
            ) &&
            (identical(other.yearsExperience, yearsExperience) ||
                other.yearsExperience == yearsExperience) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.instagramHandle, instagramHandle) ||
                other.instagramHandle == instagramHandle) &&
            const DeepCollectionEquality().equals(
              other._portfolioImages,
              _portfolioImages,
            ) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.totalJobs, totalJobs) ||
                other.totalJobs == totalJobs) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    fullName,
    username,
    bio,
    avatarUrl,
    coverImageUrl,
    role,
    location,
    travelRadius,
    hourlyRate,
    dayRate,
    const DeepCollectionEquality().hash(_skills),
    const DeepCollectionEquality().hash(_equipment),
    yearsExperience,
    website,
    instagramHandle,
    const DeepCollectionEquality().hash(_portfolioImages),
    isVerified,
    isAvailable,
    rating,
    totalJobs,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(this);
  }
}

abstract class _Profile implements Profile {
  const factory _Profile({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'full_name') final String? fullName,
    final String? username,
    final String? bio,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'cover_image_url') final String? coverImageUrl,
    final UserRole? role,
    final String? location,
    @JsonKey(name: 'travel_radius') final int? travelRadius,
    @JsonKey(name: 'hourly_rate') final double? hourlyRate,
    @JsonKey(name: 'day_rate') final double? dayRate,
    final List<String>? skills,
    final List<String>? equipment,
    @JsonKey(name: 'years_experience') final int? yearsExperience,
    final String? website,
    @JsonKey(name: 'instagram_handle') final String? instagramHandle,
    @JsonKey(name: 'portfolio_images') final List<String>? portfolioImages,
    @JsonKey(name: 'is_verified') final bool isVerified,
    @JsonKey(name: 'is_available') final bool isAvailable,
    final double rating,
    @JsonKey(name: 'total_jobs') final int totalJobs,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'full_name')
  String? get fullName;
  @override
  String? get username;
  @override
  String? get bio;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'cover_image_url')
  String? get coverImageUrl;
  @override
  UserRole? get role;
  @override
  String? get location;
  @override
  @JsonKey(name: 'travel_radius')
  int? get travelRadius;
  @override
  @JsonKey(name: 'hourly_rate')
  double? get hourlyRate;
  @override
  @JsonKey(name: 'day_rate')
  double? get dayRate;
  @override
  List<String>? get skills;
  @override
  List<String>? get equipment;
  @override
  @JsonKey(name: 'years_experience')
  int? get yearsExperience;
  @override
  String? get website;
  @override
  @JsonKey(name: 'instagram_handle')
  String? get instagramHandle;
  @override
  @JsonKey(name: 'portfolio_images')
  List<String>? get portfolioImages;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @override
  double get rating;
  @override
  @JsonKey(name: 'total_jobs')
  int get totalJobs;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContentPost _$ContentPostFromJson(Map<String, dynamic> json) {
  return _ContentPost.fromJson(json);
}

/// @nodoc
mixin _$ContentPost {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get userProfileImageUrl => throw _privateConstructorUsedError;
  PostType get postType => throw _privateConstructorUsedError; // Content fields
  String get imageUrl => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  String get caption => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError; // Location
  String? get location => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude =>
      throw _privateConstructorUsedError; // Engagement metrics
  int get likesCount => throw _privateConstructorUsedError;
  int get commentsCount => throw _privateConstructorUsedError;
  int get savesCount => throw _privateConstructorUsedError;
  int get sharesCount => throw _privateConstructorUsedError;
  List<String> get likedByUserIds => throw _privateConstructorUsedError;
  List<String> get savedByUserIds =>
      throw _privateConstructorUsedError; // Collaboration/tagging
  List<String> get taggedUserIds => throw _privateConstructorUsedError;
  List<String> get taggedUsernames =>
      throw _privateConstructorUsedError; // Listing association (if this is a job listing post)
  String? get associatedListingId =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Privacy & settings
  bool get isPublic => throw _privateConstructorUsedError;
  bool get commentsEnabled => throw _privateConstructorUsedError;
  bool get isPromoted =>
      throw _privateConstructorUsedError; // Additional metadata
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ContentPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentPostCopyWith<ContentPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentPostCopyWith<$Res> {
  factory $ContentPostCopyWith(
    ContentPost value,
    $Res Function(ContentPost) then,
  ) = _$ContentPostCopyWithImpl<$Res, ContentPost>;
  @useResult
  $Res call({
    String id,
    String userId,
    String username,
    String? userProfileImageUrl,
    PostType postType,
    String imageUrl,
    String? videoUrl,
    String caption,
    List<String>? tags,
    String? location,
    double? latitude,
    double? longitude,
    int likesCount,
    int commentsCount,
    int savesCount,
    int sharesCount,
    List<String> likedByUserIds,
    List<String> savedByUserIds,
    List<String> taggedUserIds,
    List<String> taggedUsernames,
    String? associatedListingId,
    DateTime createdAt,
    DateTime? updatedAt,
    bool isPublic,
    bool commentsEnabled,
    bool isPromoted,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$ContentPostCopyWithImpl<$Res, $Val extends ContentPost>
    implements $ContentPostCopyWith<$Res> {
  _$ContentPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? username = null,
    Object? userProfileImageUrl = freezed,
    Object? postType = null,
    Object? imageUrl = null,
    Object? videoUrl = freezed,
    Object? caption = null,
    Object? tags = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? savesCount = null,
    Object? sharesCount = null,
    Object? likedByUserIds = null,
    Object? savedByUserIds = null,
    Object? taggedUserIds = null,
    Object? taggedUsernames = null,
    Object? associatedListingId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isPublic = null,
    Object? commentsEnabled = null,
    Object? isPromoted = null,
    Object? metadata = freezed,
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
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            userProfileImageUrl: freezed == userProfileImageUrl
                ? _value.userProfileImageUrl
                : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            postType: null == postType
                ? _value.postType
                : postType // ignore: cast_nullable_to_non_nullable
                      as PostType,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            caption: null == caption
                ? _value.caption
                : caption // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            likesCount: null == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentsCount: null == commentsCount
                ? _value.commentsCount
                : commentsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            savesCount: null == savesCount
                ? _value.savesCount
                : savesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            sharesCount: null == sharesCount
                ? _value.sharesCount
                : sharesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            likedByUserIds: null == likedByUserIds
                ? _value.likedByUserIds
                : likedByUserIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            savedByUserIds: null == savedByUserIds
                ? _value.savedByUserIds
                : savedByUserIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            taggedUserIds: null == taggedUserIds
                ? _value.taggedUserIds
                : taggedUserIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            taggedUsernames: null == taggedUsernames
                ? _value.taggedUsernames
                : taggedUsernames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            associatedListingId: freezed == associatedListingId
                ? _value.associatedListingId
                : associatedListingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            commentsEnabled: null == commentsEnabled
                ? _value.commentsEnabled
                : commentsEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPromoted: null == isPromoted
                ? _value.isPromoted
                : isPromoted // ignore: cast_nullable_to_non_nullable
                      as bool,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContentPostImplCopyWith<$Res>
    implements $ContentPostCopyWith<$Res> {
  factory _$$ContentPostImplCopyWith(
    _$ContentPostImpl value,
    $Res Function(_$ContentPostImpl) then,
  ) = __$$ContentPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String username,
    String? userProfileImageUrl,
    PostType postType,
    String imageUrl,
    String? videoUrl,
    String caption,
    List<String>? tags,
    String? location,
    double? latitude,
    double? longitude,
    int likesCount,
    int commentsCount,
    int savesCount,
    int sharesCount,
    List<String> likedByUserIds,
    List<String> savedByUserIds,
    List<String> taggedUserIds,
    List<String> taggedUsernames,
    String? associatedListingId,
    DateTime createdAt,
    DateTime? updatedAt,
    bool isPublic,
    bool commentsEnabled,
    bool isPromoted,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$ContentPostImplCopyWithImpl<$Res>
    extends _$ContentPostCopyWithImpl<$Res, _$ContentPostImpl>
    implements _$$ContentPostImplCopyWith<$Res> {
  __$$ContentPostImplCopyWithImpl(
    _$ContentPostImpl _value,
    $Res Function(_$ContentPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContentPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? username = null,
    Object? userProfileImageUrl = freezed,
    Object? postType = null,
    Object? imageUrl = null,
    Object? videoUrl = freezed,
    Object? caption = null,
    Object? tags = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? savesCount = null,
    Object? sharesCount = null,
    Object? likedByUserIds = null,
    Object? savedByUserIds = null,
    Object? taggedUserIds = null,
    Object? taggedUsernames = null,
    Object? associatedListingId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isPublic = null,
    Object? commentsEnabled = null,
    Object? isPromoted = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _$ContentPostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        userProfileImageUrl: freezed == userProfileImageUrl
            ? _value.userProfileImageUrl
            : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        postType: null == postType
            ? _value.postType
            : postType // ignore: cast_nullable_to_non_nullable
                  as PostType,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        caption: null == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        likesCount: null == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentsCount: null == commentsCount
            ? _value.commentsCount
            : commentsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        savesCount: null == savesCount
            ? _value.savesCount
            : savesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        sharesCount: null == sharesCount
            ? _value.sharesCount
            : sharesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        likedByUserIds: null == likedByUserIds
            ? _value._likedByUserIds
            : likedByUserIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        savedByUserIds: null == savedByUserIds
            ? _value._savedByUserIds
            : savedByUserIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        taggedUserIds: null == taggedUserIds
            ? _value._taggedUserIds
            : taggedUserIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        taggedUsernames: null == taggedUsernames
            ? _value._taggedUsernames
            : taggedUsernames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        associatedListingId: freezed == associatedListingId
            ? _value.associatedListingId
            : associatedListingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        commentsEnabled: null == commentsEnabled
            ? _value.commentsEnabled
            : commentsEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPromoted: null == isPromoted
            ? _value.isPromoted
            : isPromoted // ignore: cast_nullable_to_non_nullable
                  as bool,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentPostImpl implements _ContentPost {
  const _$ContentPostImpl({
    required this.id,
    required this.userId,
    required this.username,
    this.userProfileImageUrl,
    required this.postType,
    required this.imageUrl,
    this.videoUrl,
    required this.caption,
    final List<String>? tags,
    this.location,
    this.latitude,
    this.longitude,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.savesCount = 0,
    this.sharesCount = 0,
    final List<String> likedByUserIds = const [],
    final List<String> savedByUserIds = const [],
    final List<String> taggedUserIds = const [],
    final List<String> taggedUsernames = const [],
    this.associatedListingId,
    required this.createdAt,
    this.updatedAt,
    this.isPublic = true,
    this.commentsEnabled = false,
    this.isPromoted = false,
    final Map<String, dynamic>? metadata,
  }) : _tags = tags,
       _likedByUserIds = likedByUserIds,
       _savedByUserIds = savedByUserIds,
       _taggedUserIds = taggedUserIds,
       _taggedUsernames = taggedUsernames,
       _metadata = metadata;

  factory _$ContentPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentPostImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String username;
  @override
  final String? userProfileImageUrl;
  @override
  final PostType postType;
  // Content fields
  @override
  final String imageUrl;
  @override
  final String? videoUrl;
  @override
  final String caption;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Location
  @override
  final String? location;
  @override
  final double? latitude;
  @override
  final double? longitude;
  // Engagement metrics
  @override
  @JsonKey()
  final int likesCount;
  @override
  @JsonKey()
  final int commentsCount;
  @override
  @JsonKey()
  final int savesCount;
  @override
  @JsonKey()
  final int sharesCount;
  final List<String> _likedByUserIds;
  @override
  @JsonKey()
  List<String> get likedByUserIds {
    if (_likedByUserIds is EqualUnmodifiableListView) return _likedByUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedByUserIds);
  }

  final List<String> _savedByUserIds;
  @override
  @JsonKey()
  List<String> get savedByUserIds {
    if (_savedByUserIds is EqualUnmodifiableListView) return _savedByUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedByUserIds);
  }

  // Collaboration/tagging
  final List<String> _taggedUserIds;
  // Collaboration/tagging
  @override
  @JsonKey()
  List<String> get taggedUserIds {
    if (_taggedUserIds is EqualUnmodifiableListView) return _taggedUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taggedUserIds);
  }

  final List<String> _taggedUsernames;
  @override
  @JsonKey()
  List<String> get taggedUsernames {
    if (_taggedUsernames is EqualUnmodifiableListView) return _taggedUsernames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taggedUsernames);
  }

  // Listing association (if this is a job listing post)
  @override
  final String? associatedListingId;
  // Timestamps
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  // Privacy & settings
  @override
  @JsonKey()
  final bool isPublic;
  @override
  @JsonKey()
  final bool commentsEnabled;
  @override
  @JsonKey()
  final bool isPromoted;
  // Additional metadata
  final Map<String, dynamic>? _metadata;
  // Additional metadata
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ContentPost(id: $id, userId: $userId, username: $username, userProfileImageUrl: $userProfileImageUrl, postType: $postType, imageUrl: $imageUrl, videoUrl: $videoUrl, caption: $caption, tags: $tags, location: $location, latitude: $latitude, longitude: $longitude, likesCount: $likesCount, commentsCount: $commentsCount, savesCount: $savesCount, sharesCount: $sharesCount, likedByUserIds: $likedByUserIds, savedByUserIds: $savedByUserIds, taggedUserIds: $taggedUserIds, taggedUsernames: $taggedUsernames, associatedListingId: $associatedListingId, createdAt: $createdAt, updatedAt: $updatedAt, isPublic: $isPublic, commentsEnabled: $commentsEnabled, isPromoted: $isPromoted, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.userProfileImageUrl, userProfileImageUrl) ||
                other.userProfileImageUrl == userProfileImageUrl) &&
            (identical(other.postType, postType) ||
                other.postType == postType) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.savesCount, savesCount) ||
                other.savesCount == savesCount) &&
            (identical(other.sharesCount, sharesCount) ||
                other.sharesCount == sharesCount) &&
            const DeepCollectionEquality().equals(
              other._likedByUserIds,
              _likedByUserIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._savedByUserIds,
              _savedByUserIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._taggedUserIds,
              _taggedUserIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._taggedUsernames,
              _taggedUsernames,
            ) &&
            (identical(other.associatedListingId, associatedListingId) ||
                other.associatedListingId == associatedListingId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.commentsEnabled, commentsEnabled) ||
                other.commentsEnabled == commentsEnabled) &&
            (identical(other.isPromoted, isPromoted) ||
                other.isPromoted == isPromoted) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    username,
    userProfileImageUrl,
    postType,
    imageUrl,
    videoUrl,
    caption,
    const DeepCollectionEquality().hash(_tags),
    location,
    latitude,
    longitude,
    likesCount,
    commentsCount,
    savesCount,
    sharesCount,
    const DeepCollectionEquality().hash(_likedByUserIds),
    const DeepCollectionEquality().hash(_savedByUserIds),
    const DeepCollectionEquality().hash(_taggedUserIds),
    const DeepCollectionEquality().hash(_taggedUsernames),
    associatedListingId,
    createdAt,
    updatedAt,
    isPublic,
    commentsEnabled,
    isPromoted,
    const DeepCollectionEquality().hash(_metadata),
  ]);

  /// Create a copy of ContentPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentPostImplCopyWith<_$ContentPostImpl> get copyWith =>
      __$$ContentPostImplCopyWithImpl<_$ContentPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentPostImplToJson(this);
  }
}

abstract class _ContentPost implements ContentPost {
  const factory _ContentPost({
    required final String id,
    required final String userId,
    required final String username,
    final String? userProfileImageUrl,
    required final PostType postType,
    required final String imageUrl,
    final String? videoUrl,
    required final String caption,
    final List<String>? tags,
    final String? location,
    final double? latitude,
    final double? longitude,
    final int likesCount,
    final int commentsCount,
    final int savesCount,
    final int sharesCount,
    final List<String> likedByUserIds,
    final List<String> savedByUserIds,
    final List<String> taggedUserIds,
    final List<String> taggedUsernames,
    final String? associatedListingId,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final bool isPublic,
    final bool commentsEnabled,
    final bool isPromoted,
    final Map<String, dynamic>? metadata,
  }) = _$ContentPostImpl;

  factory _ContentPost.fromJson(Map<String, dynamic> json) =
      _$ContentPostImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get username;
  @override
  String? get userProfileImageUrl;
  @override
  PostType get postType; // Content fields
  @override
  String get imageUrl;
  @override
  String? get videoUrl;
  @override
  String get caption;
  @override
  List<String>? get tags; // Location
  @override
  String? get location;
  @override
  double? get latitude;
  @override
  double? get longitude; // Engagement metrics
  @override
  int get likesCount;
  @override
  int get commentsCount;
  @override
  int get savesCount;
  @override
  int get sharesCount;
  @override
  List<String> get likedByUserIds;
  @override
  List<String> get savedByUserIds; // Collaboration/tagging
  @override
  List<String> get taggedUserIds;
  @override
  List<String> get taggedUsernames; // Listing association (if this is a job listing post)
  @override
  String? get associatedListingId; // Timestamps
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt; // Privacy & settings
  @override
  bool get isPublic;
  @override
  bool get commentsEnabled;
  @override
  bool get isPromoted; // Additional metadata
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ContentPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentPostImplCopyWith<_$ContentPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  String get id => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get userProfileImageUrl => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;
  List<String> get likedByUserIds => throw _privateConstructorUsedError;
  String? get replyToCommentId => throw _privateConstructorUsedError;

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call({
    String id,
    String postId,
    String userId,
    String username,
    String? userProfileImageUrl,
    String text,
    DateTime createdAt,
    int likesCount,
    List<String> likedByUserIds,
    String? replyToCommentId,
  });
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? userId = null,
    Object? username = null,
    Object? userProfileImageUrl = freezed,
    Object? text = null,
    Object? createdAt = null,
    Object? likesCount = null,
    Object? likedByUserIds = null,
    Object? replyToCommentId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            postId: null == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            userProfileImageUrl: freezed == userProfileImageUrl
                ? _value.userProfileImageUrl
                : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            likesCount: null == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            likedByUserIds: null == likedByUserIds
                ? _value.likedByUserIds
                : likedByUserIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            replyToCommentId: freezed == replyToCommentId
                ? _value.replyToCommentId
                : replyToCommentId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
    _$CommentImpl value,
    $Res Function(_$CommentImpl) then,
  ) = __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String postId,
    String userId,
    String username,
    String? userProfileImageUrl,
    String text,
    DateTime createdAt,
    int likesCount,
    List<String> likedByUserIds,
    String? replyToCommentId,
  });
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
    _$CommentImpl _value,
    $Res Function(_$CommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? userId = null,
    Object? username = null,
    Object? userProfileImageUrl = freezed,
    Object? text = null,
    Object? createdAt = null,
    Object? likesCount = null,
    Object? likedByUserIds = null,
    Object? replyToCommentId = freezed,
  }) {
    return _then(
      _$CommentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        postId: null == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        userProfileImageUrl: freezed == userProfileImageUrl
            ? _value.userProfileImageUrl
            : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        likesCount: null == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        likedByUserIds: null == likedByUserIds
            ? _value._likedByUserIds
            : likedByUserIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        replyToCommentId: freezed == replyToCommentId
            ? _value.replyToCommentId
            : replyToCommentId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl implements _Comment {
  const _$CommentImpl({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    this.userProfileImageUrl,
    required this.text,
    required this.createdAt,
    this.likesCount = 0,
    final List<String> likedByUserIds = const [],
    this.replyToCommentId,
  }) : _likedByUserIds = likedByUserIds;

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  final String id;
  @override
  final String postId;
  @override
  final String userId;
  @override
  final String username;
  @override
  final String? userProfileImageUrl;
  @override
  final String text;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int likesCount;
  final List<String> _likedByUserIds;
  @override
  @JsonKey()
  List<String> get likedByUserIds {
    if (_likedByUserIds is EqualUnmodifiableListView) return _likedByUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedByUserIds);
  }

  @override
  final String? replyToCommentId;

  @override
  String toString() {
    return 'Comment(id: $id, postId: $postId, userId: $userId, username: $username, userProfileImageUrl: $userProfileImageUrl, text: $text, createdAt: $createdAt, likesCount: $likesCount, likedByUserIds: $likedByUserIds, replyToCommentId: $replyToCommentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.userProfileImageUrl, userProfileImageUrl) ||
                other.userProfileImageUrl == userProfileImageUrl) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            const DeepCollectionEquality().equals(
              other._likedByUserIds,
              _likedByUserIds,
            ) &&
            (identical(other.replyToCommentId, replyToCommentId) ||
                other.replyToCommentId == replyToCommentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    postId,
    userId,
    username,
    userProfileImageUrl,
    text,
    createdAt,
    likesCount,
    const DeepCollectionEquality().hash(_likedByUserIds),
    replyToCommentId,
  );

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(this);
  }
}

abstract class _Comment implements Comment {
  const factory _Comment({
    required final String id,
    required final String postId,
    required final String userId,
    required final String username,
    final String? userProfileImageUrl,
    required final String text,
    required final DateTime createdAt,
    final int likesCount,
    final List<String> likedByUserIds,
    final String? replyToCommentId,
  }) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  String get id;
  @override
  String get postId;
  @override
  String get userId;
  @override
  String get username;
  @override
  String? get userProfileImageUrl;
  @override
  String get text;
  @override
  DateTime get createdAt;
  @override
  int get likesCount;
  @override
  List<String> get likedByUserIds;
  @override
  String? get replyToCommentId;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostInteraction _$PostInteractionFromJson(Map<String, dynamic> json) {
  return _PostInteraction.fromJson(json);
}

/// @nodoc
mixin _$PostInteraction {
  String get userId => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  InteractionType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this PostInteraction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostInteractionCopyWith<PostInteraction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostInteractionCopyWith<$Res> {
  factory $PostInteractionCopyWith(
    PostInteraction value,
    $Res Function(PostInteraction) then,
  ) = _$PostInteractionCopyWithImpl<$Res, PostInteraction>;
  @useResult
  $Res call({
    String userId,
    String postId,
    InteractionType type,
    DateTime timestamp,
  });
}

/// @nodoc
class _$PostInteractionCopyWithImpl<$Res, $Val extends PostInteraction>
    implements $PostInteractionCopyWith<$Res> {
  _$PostInteractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? postId = null,
    Object? type = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            postId: null == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as InteractionType,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostInteractionImplCopyWith<$Res>
    implements $PostInteractionCopyWith<$Res> {
  factory _$$PostInteractionImplCopyWith(
    _$PostInteractionImpl value,
    $Res Function(_$PostInteractionImpl) then,
  ) = __$$PostInteractionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String postId,
    InteractionType type,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$PostInteractionImplCopyWithImpl<$Res>
    extends _$PostInteractionCopyWithImpl<$Res, _$PostInteractionImpl>
    implements _$$PostInteractionImplCopyWith<$Res> {
  __$$PostInteractionImplCopyWithImpl(
    _$PostInteractionImpl _value,
    $Res Function(_$PostInteractionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? postId = null,
    Object? type = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$PostInteractionImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        postId: null == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as InteractionType,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostInteractionImpl implements _PostInteraction {
  const _$PostInteractionImpl({
    required this.userId,
    required this.postId,
    required this.type,
    required this.timestamp,
  });

  factory _$PostInteractionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostInteractionImplFromJson(json);

  @override
  final String userId;
  @override
  final String postId;
  @override
  final InteractionType type;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'PostInteraction(userId: $userId, postId: $postId, type: $type, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostInteractionImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, postId, type, timestamp);

  /// Create a copy of PostInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostInteractionImplCopyWith<_$PostInteractionImpl> get copyWith =>
      __$$PostInteractionImplCopyWithImpl<_$PostInteractionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PostInteractionImplToJson(this);
  }
}

abstract class _PostInteraction implements PostInteraction {
  const factory _PostInteraction({
    required final String userId,
    required final String postId,
    required final InteractionType type,
    required final DateTime timestamp,
  }) = _$PostInteractionImpl;

  factory _PostInteraction.fromJson(Map<String, dynamic> json) =
      _$PostInteractionImpl.fromJson;

  @override
  String get userId;
  @override
  String get postId;
  @override
  InteractionType get type;
  @override
  DateTime get timestamp;

  /// Create a copy of PostInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostInteractionImplCopyWith<_$PostInteractionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

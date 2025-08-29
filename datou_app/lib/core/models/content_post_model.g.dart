// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentPostImpl _$$ContentPostImplFromJson(Map<String, dynamic> json) =>
    _$ContentPostImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      userProfileImageUrl: json['userProfileImageUrl'] as String?,
      postType: $enumDecode(_$PostTypeEnumMap, json['postType']),
      imageUrl: json['imageUrl'] as String,
      videoUrl: json['videoUrl'] as String?,
      caption: json['caption'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      savesCount: (json['savesCount'] as num?)?.toInt() ?? 0,
      sharesCount: (json['sharesCount'] as num?)?.toInt() ?? 0,
      likedByUserIds:
          (json['likedByUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      savedByUserIds:
          (json['savedByUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      taggedUserIds:
          (json['taggedUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      taggedUsernames:
          (json['taggedUsernames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      associatedListingId: json['associatedListingId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isPublic: json['isPublic'] as bool? ?? true,
      commentsEnabled: json['commentsEnabled'] as bool? ?? false,
      isPromoted: json['isPromoted'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ContentPostImplToJson(_$ContentPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'username': instance.username,
      'userProfileImageUrl': instance.userProfileImageUrl,
      'postType': _$PostTypeEnumMap[instance.postType]!,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'caption': instance.caption,
      'tags': instance.tags,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'savesCount': instance.savesCount,
      'sharesCount': instance.sharesCount,
      'likedByUserIds': instance.likedByUserIds,
      'savedByUserIds': instance.savedByUserIds,
      'taggedUserIds': instance.taggedUserIds,
      'taggedUsernames': instance.taggedUsernames,
      'associatedListingId': instance.associatedListingId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isPublic': instance.isPublic,
      'commentsEnabled': instance.commentsEnabled,
      'isPromoted': instance.isPromoted,
      'metadata': instance.metadata,
    };

const _$PostTypeEnumMap = {
  PostType.content: 'content',
  PostType.listing: 'listing',
  PostType.portfolio: 'portfolio',
  PostType.announcement: 'announcement',
};

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      userProfileImageUrl: json['userProfileImageUrl'] as String?,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      likedByUserIds:
          (json['likedByUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      replyToCommentId: json['replyToCommentId'] as String?,
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'username': instance.username,
      'userProfileImageUrl': instance.userProfileImageUrl,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'likesCount': instance.likesCount,
      'likedByUserIds': instance.likedByUserIds,
      'replyToCommentId': instance.replyToCommentId,
    };

_$PostInteractionImpl _$$PostInteractionImplFromJson(
  Map<String, dynamic> json,
) => _$PostInteractionImpl(
  userId: json['userId'] as String,
  postId: json['postId'] as String,
  type: $enumDecode(_$InteractionTypeEnumMap, json['type']),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$PostInteractionImplToJson(
  _$PostInteractionImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'postId': instance.postId,
  'type': _$InteractionTypeEnumMap[instance.type]!,
  'timestamp': instance.timestamp.toIso8601String(),
};

const _$InteractionTypeEnumMap = {
  InteractionType.like: 'like',
  InteractionType.save: 'save',
  InteractionType.share: 'share',
  InteractionType.comment: 'comment',
};

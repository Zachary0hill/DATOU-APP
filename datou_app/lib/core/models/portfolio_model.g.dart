// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortfolioImpl _$$PortfolioImplFromJson(Map<String, dynamic> json) =>
    _$PortfolioImpl(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      mediaUrl: json['media_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['media_type']),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      shootDate: json['shoot_date'] == null
          ? null
          : DateTime.parse(json['shoot_date'] as String),
      location: json['location'] as String?,
      cameraSettings: json['camera_settings'] as Map<String, dynamic>?,
      isFeatured: json['is_featured'] as bool? ?? false,
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$PortfolioImplToJson(_$PortfolioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'title': instance.title,
      'description': instance.description,
      'media_url': instance.mediaUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'media_type': _$MediaTypeEnumMap[instance.mediaType]!,
      'tags': instance.tags,
      'shoot_date': instance.shootDate?.toIso8601String(),
      'location': instance.location,
      'camera_settings': instance.cameraSettings,
      'is_featured': instance.isFeatured,
      'view_count': instance.viewCount,
      'like_count': instance.likeCount,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$MediaTypeEnumMap = {MediaType.image: 'image', MediaType.video: 'video'};

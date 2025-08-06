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
      budget: (json['budget'] as num).toDouble(),
      isNegotiable: json['is_negotiable'] as bool? ?? true,
      location: json['location'] as String,
      eventDate: json['event_date'] == null
          ? null
          : DateTime.parse(json['event_date'] as String),
      eventDurationHours: (json['event_duration'] as num?)?.toInt(),
      applicationDeadline: json['application_deadline'] == null
          ? null
          : DateTime.parse(json['application_deadline'] as String),
      requiredSkills: (json['required_skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferredExperience: (json['preferred_experience'] as num?)?.toInt(),
      contactMethod: json['contact_method'] as String? ?? 'in_app',
      imageUrls: (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status:
          $enumDecodeNullable(_$ListingStatusEnumMap, json['status']) ??
          ListingStatus.draft,
      isUrgent: json['is_urgent'] as bool? ?? false,
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
      applicationCount: (json['application_count'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$ListingImplToJson(_$ListingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'title': instance.title,
      'description': instance.description,
      'type': _$ListingTypeEnumMap[instance.type]!,
      'required_role': _$UserRoleEnumMap[instance.requiredRole],
      'budget': instance.budget,
      'is_negotiable': instance.isNegotiable,
      'location': instance.location,
      'event_date': instance.eventDate?.toIso8601String(),
      'event_duration': instance.eventDurationHours,
      'application_deadline': instance.applicationDeadline?.toIso8601String(),
      'required_skills': instance.requiredSkills,
      'preferred_experience': instance.preferredExperience,
      'contact_method': instance.contactMethod,
      'image_urls': instance.imageUrls,
      'status': _$ListingStatusEnumMap[instance.status]!,
      'is_urgent': instance.isUrgent,
      'view_count': instance.viewCount,
      'application_count': instance.applicationCount,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
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

const _$ListingStatusEnumMap = {
  ListingStatus.draft: 'draft',
  ListingStatus.active: 'active',
  ListingStatus.paused: 'paused',
  ListingStatus.completed: 'completed',
  ListingStatus.cancelled: 'cancelled',
};

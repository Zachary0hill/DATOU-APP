// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String?,
      username: json['username'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
      location: json['location'] as String?,
      travelRadius: (json['travel_radius'] as num?)?.toInt(),
      hourlyRate: (json['hourly_rate'] as num?)?.toDouble(),
      dayRate: (json['day_rate'] as num?)?.toDouble(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      equipment: (json['equipment'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      yearsExperience: (json['years_experience'] as num?)?.toInt(),
      website: json['website'] as String?,
      instagramHandle: json['instagram_handle'] as String?,
      portfolioImages: (json['portfolio_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isVerified: json['is_verified'] as bool? ?? false,
      isAvailable: json['is_available'] as bool? ?? true,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalJobs: (json['total_jobs'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'username': instance.username,
      'bio': instance.bio,
      'avatar_url': instance.avatarUrl,
      'cover_image_url': instance.coverImageUrl,
      'role': _$UserRoleEnumMap[instance.role],
      'location': instance.location,
      'travel_radius': instance.travelRadius,
      'hourly_rate': instance.hourlyRate,
      'day_rate': instance.dayRate,
      'skills': instance.skills,
      'equipment': instance.equipment,
      'years_experience': instance.yearsExperience,
      'website': instance.website,
      'instagram_handle': instance.instagramHandle,
      'portfolio_images': instance.portfolioImages,
      'is_verified': instance.isVerified,
      'is_available': instance.isAvailable,
      'rating': instance.rating,
      'total_jobs': instance.totalJobs,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.photographer: 'photographer',
  UserRole.videographer: 'videographer',
  UserRole.model: 'model',
  UserRole.agency: 'agency',
};

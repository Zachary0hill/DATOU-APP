// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationImpl _$$ApplicationImplFromJson(Map<String, dynamic> json) =>
    _$ApplicationImpl(
      id: json['id'] as String,
      listingId: json['listing_id'] as String,
      applicantId: json['applicant_id'] as String,
      coverLetter: json['cover_letter'] as String?,
      proposedRate: (json['proposed_rate'] as num?)?.toDouble(),
      portfolioLinks: (json['portfolio_links'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      availabilityNotes: json['availability_notes'] as String?,
      status:
          $enumDecodeNullable(_$ApplicationStatusEnumMap, json['status']) ??
          ApplicationStatus.pending,
      appliedAt: DateTime.parse(json['applied_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      responseMessage: json['response_message'] as String?,
      respondedAt: json['responded_at'] == null
          ? null
          : DateTime.parse(json['responded_at'] as String),
    );

Map<String, dynamic> _$$ApplicationImplToJson(_$ApplicationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listingId,
      'applicant_id': instance.applicantId,
      'cover_letter': instance.coverLetter,
      'proposed_rate': instance.proposedRate,
      'portfolio_links': instance.portfolioLinks,
      'availability_notes': instance.availabilityNotes,
      'status': _$ApplicationStatusEnumMap[instance.status]!,
      'applied_at': instance.appliedAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'response_message': instance.responseMessage,
      'responded_at': instance.respondedAt?.toIso8601String(),
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.pending: 'pending',
  ApplicationStatus.accepted: 'accepted',
  ApplicationStatus.rejected: 'rejected',
  ApplicationStatus.withdrawn: 'withdrawn',
};

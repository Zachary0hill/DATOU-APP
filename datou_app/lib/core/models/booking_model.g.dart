// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingImpl _$$BookingImplFromJson(Map<String, dynamic> json) =>
    _$BookingImpl(
      id: json['id'] as String,
      listingId: json['listing_id'] as String,
      clientId: json['client_id'] as String,
      providerId: json['provider_id'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      totalAmount: (json['total_amount'] as num).toDouble(),
      platformFee: (json['platform_fee'] as num).toDouble(),
      providerAmount: (json['provider_amount'] as num).toDouble(),
      status:
          $enumDecodeNullable(_$BookingStatusEnumMap, json['status']) ??
          BookingStatus.pending,
      paymentIntentId: json['payment_intent_id'] as String?,
      specialInstructions: json['special_instructions'] as String?,
      meetingLocation: json['meeting_location'] as String?,
      clientNotes: json['client_notes'] as String?,
      providerNotes: json['provider_notes'] as String?,
      isPaid: json['is_paid'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      cancellationReason: json['cancellation_reason'] as String?,
    );

Map<String, dynamic> _$$BookingImplToJson(_$BookingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listingId,
      'client_id': instance.clientId,
      'provider_id': instance.providerId,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'total_amount': instance.totalAmount,
      'platform_fee': instance.platformFee,
      'provider_amount': instance.providerAmount,
      'status': _$BookingStatusEnumMap[instance.status]!,
      'payment_intent_id': instance.paymentIntentId,
      'special_instructions': instance.specialInstructions,
      'meeting_location': instance.meetingLocation,
      'client_notes': instance.clientNotes,
      'provider_notes': instance.providerNotes,
      'is_paid': instance.isPaid,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'cancellation_reason': instance.cancellationReason,
    };

const _$BookingStatusEnumMap = {
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.pending: 'pending',
  BookingStatus.completed: 'completed',
  BookingStatus.cancelled: 'cancelled',
};

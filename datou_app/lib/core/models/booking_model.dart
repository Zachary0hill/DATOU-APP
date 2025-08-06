import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

enum BookingStatus { confirmed, pending, completed, cancelled }

@freezed
class Booking with _$Booking {
  const factory Booking({
    required String id,
    @JsonKey(name: 'listing_id') required String listingId,
    @JsonKey(name: 'client_id') required String clientId,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(name: 'platform_fee') required double platformFee,
    @JsonKey(name: 'provider_amount') required double providerAmount,
    @Default(BookingStatus.pending) BookingStatus status,
    @JsonKey(name: 'payment_intent_id') String? paymentIntentId,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'meeting_location') String? meetingLocation,
    @JsonKey(name: 'client_notes') String? clientNotes,
    @JsonKey(name: 'provider_notes') String? providerNotes,
    @JsonKey(name: 'is_paid') @Default(false) bool isPaid,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
    @JsonKey(name: 'cancellation_reason') String? cancellationReason,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
}
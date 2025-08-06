// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

/// @nodoc
mixin _$Booking {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'listing_id')
  String get listingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_id')
  String get clientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider_id')
  String get providerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  DateTime get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'platform_fee')
  double get platformFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider_amount')
  double get providerAmount => throw _privateConstructorUsedError;
  BookingStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_intent_id')
  String? get paymentIntentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'special_instructions')
  String? get specialInstructions => throw _privateConstructorUsedError;
  @JsonKey(name: 'meeting_location')
  String? get meetingLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_notes')
  String? get clientNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider_notes')
  String? get providerNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_paid')
  bool get isPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancellation_reason')
  String? get cancellationReason => throw _privateConstructorUsedError;

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res, Booking>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'listing_id') String listingId,
    @JsonKey(name: 'client_id') String clientId,
    @JsonKey(name: 'provider_id') String providerId,
    @JsonKey(name: 'start_date') DateTime startDate,
    @JsonKey(name: 'end_date') DateTime endDate,
    @JsonKey(name: 'total_amount') double totalAmount,
    @JsonKey(name: 'platform_fee') double platformFee,
    @JsonKey(name: 'provider_amount') double providerAmount,
    BookingStatus status,
    @JsonKey(name: 'payment_intent_id') String? paymentIntentId,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'meeting_location') String? meetingLocation,
    @JsonKey(name: 'client_notes') String? clientNotes,
    @JsonKey(name: 'provider_notes') String? providerNotes,
    @JsonKey(name: 'is_paid') bool isPaid,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
    @JsonKey(name: 'cancellation_reason') String? cancellationReason,
  });
}

/// @nodoc
class _$BookingCopyWithImpl<$Res, $Val extends Booking>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? clientId = null,
    Object? providerId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalAmount = null,
    Object? platformFee = null,
    Object? providerAmount = null,
    Object? status = null,
    Object? paymentIntentId = freezed,
    Object? specialInstructions = freezed,
    Object? meetingLocation = freezed,
    Object? clientNotes = freezed,
    Object? providerNotes = freezed,
    Object? isPaid = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            listingId: null == listingId
                ? _value.listingId
                : listingId // ignore: cast_nullable_to_non_nullable
                      as String,
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String,
            providerId: null == providerId
                ? _value.providerId
                : providerId // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            platformFee: null == platformFee
                ? _value.platformFee
                : platformFee // ignore: cast_nullable_to_non_nullable
                      as double,
            providerAmount: null == providerAmount
                ? _value.providerAmount
                : providerAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BookingStatus,
            paymentIntentId: freezed == paymentIntentId
                ? _value.paymentIntentId
                : paymentIntentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialInstructions: freezed == specialInstructions
                ? _value.specialInstructions
                : specialInstructions // ignore: cast_nullable_to_non_nullable
                      as String?,
            meetingLocation: freezed == meetingLocation
                ? _value.meetingLocation
                : meetingLocation // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientNotes: freezed == clientNotes
                ? _value.clientNotes
                : clientNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerNotes: freezed == providerNotes
                ? _value.providerNotes
                : providerNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPaid: null == isPaid
                ? _value.isPaid
                : isPaid // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancellationReason: freezed == cancellationReason
                ? _value.cancellationReason
                : cancellationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingImplCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$$BookingImplCopyWith(
    _$BookingImpl value,
    $Res Function(_$BookingImpl) then,
  ) = __$$BookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'listing_id') String listingId,
    @JsonKey(name: 'client_id') String clientId,
    @JsonKey(name: 'provider_id') String providerId,
    @JsonKey(name: 'start_date') DateTime startDate,
    @JsonKey(name: 'end_date') DateTime endDate,
    @JsonKey(name: 'total_amount') double totalAmount,
    @JsonKey(name: 'platform_fee') double platformFee,
    @JsonKey(name: 'provider_amount') double providerAmount,
    BookingStatus status,
    @JsonKey(name: 'payment_intent_id') String? paymentIntentId,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'meeting_location') String? meetingLocation,
    @JsonKey(name: 'client_notes') String? clientNotes,
    @JsonKey(name: 'provider_notes') String? providerNotes,
    @JsonKey(name: 'is_paid') bool isPaid,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
    @JsonKey(name: 'cancellation_reason') String? cancellationReason,
  });
}

/// @nodoc
class __$$BookingImplCopyWithImpl<$Res>
    extends _$BookingCopyWithImpl<$Res, _$BookingImpl>
    implements _$$BookingImplCopyWith<$Res> {
  __$$BookingImplCopyWithImpl(
    _$BookingImpl _value,
    $Res Function(_$BookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? clientId = null,
    Object? providerId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalAmount = null,
    Object? platformFee = null,
    Object? providerAmount = null,
    Object? status = null,
    Object? paymentIntentId = freezed,
    Object? specialInstructions = freezed,
    Object? meetingLocation = freezed,
    Object? clientNotes = freezed,
    Object? providerNotes = freezed,
    Object? isPaid = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
  }) {
    return _then(
      _$BookingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        listingId: null == listingId
            ? _value.listingId
            : listingId // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerId: null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        platformFee: null == platformFee
            ? _value.platformFee
            : platformFee // ignore: cast_nullable_to_non_nullable
                  as double,
        providerAmount: null == providerAmount
            ? _value.providerAmount
            : providerAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BookingStatus,
        paymentIntentId: freezed == paymentIntentId
            ? _value.paymentIntentId
            : paymentIntentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialInstructions: freezed == specialInstructions
            ? _value.specialInstructions
            : specialInstructions // ignore: cast_nullable_to_non_nullable
                  as String?,
        meetingLocation: freezed == meetingLocation
            ? _value.meetingLocation
            : meetingLocation // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientNotes: freezed == clientNotes
            ? _value.clientNotes
            : clientNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerNotes: freezed == providerNotes
            ? _value.providerNotes
            : providerNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPaid: null == isPaid
            ? _value.isPaid
            : isPaid // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancellationReason: freezed == cancellationReason
            ? _value.cancellationReason
            : cancellationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingImpl implements _Booking {
  const _$BookingImpl({
    required this.id,
    @JsonKey(name: 'listing_id') required this.listingId,
    @JsonKey(name: 'client_id') required this.clientId,
    @JsonKey(name: 'provider_id') required this.providerId,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') required this.endDate,
    @JsonKey(name: 'total_amount') required this.totalAmount,
    @JsonKey(name: 'platform_fee') required this.platformFee,
    @JsonKey(name: 'provider_amount') required this.providerAmount,
    this.status = BookingStatus.pending,
    @JsonKey(name: 'payment_intent_id') this.paymentIntentId,
    @JsonKey(name: 'special_instructions') this.specialInstructions,
    @JsonKey(name: 'meeting_location') this.meetingLocation,
    @JsonKey(name: 'client_notes') this.clientNotes,
    @JsonKey(name: 'provider_notes') this.providerNotes,
    @JsonKey(name: 'is_paid') this.isPaid = false,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
    @JsonKey(name: 'cancelled_at') this.cancelledAt,
    @JsonKey(name: 'cancellation_reason') this.cancellationReason,
  });

  factory _$BookingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'listing_id')
  final String listingId;
  @override
  @JsonKey(name: 'client_id')
  final String clientId;
  @override
  @JsonKey(name: 'provider_id')
  final String providerId;
  @override
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(name: 'platform_fee')
  final double platformFee;
  @override
  @JsonKey(name: 'provider_amount')
  final double providerAmount;
  @override
  @JsonKey()
  final BookingStatus status;
  @override
  @JsonKey(name: 'payment_intent_id')
  final String? paymentIntentId;
  @override
  @JsonKey(name: 'special_instructions')
  final String? specialInstructions;
  @override
  @JsonKey(name: 'meeting_location')
  final String? meetingLocation;
  @override
  @JsonKey(name: 'client_notes')
  final String? clientNotes;
  @override
  @JsonKey(name: 'provider_notes')
  final String? providerNotes;
  @override
  @JsonKey(name: 'is_paid')
  final bool isPaid;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @override
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;
  @override
  @JsonKey(name: 'cancellation_reason')
  final String? cancellationReason;

  @override
  String toString() {
    return 'Booking(id: $id, listingId: $listingId, clientId: $clientId, providerId: $providerId, startDate: $startDate, endDate: $endDate, totalAmount: $totalAmount, platformFee: $platformFee, providerAmount: $providerAmount, status: $status, paymentIntentId: $paymentIntentId, specialInstructions: $specialInstructions, meetingLocation: $meetingLocation, clientNotes: $clientNotes, providerNotes: $providerNotes, isPaid: $isPaid, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.platformFee, platformFee) ||
                other.platformFee == platformFee) &&
            (identical(other.providerAmount, providerAmount) ||
                other.providerAmount == providerAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentIntentId, paymentIntentId) ||
                other.paymentIntentId == paymentIntentId) &&
            (identical(other.specialInstructions, specialInstructions) ||
                other.specialInstructions == specialInstructions) &&
            (identical(other.meetingLocation, meetingLocation) ||
                other.meetingLocation == meetingLocation) &&
            (identical(other.clientNotes, clientNotes) ||
                other.clientNotes == clientNotes) &&
            (identical(other.providerNotes, providerNotes) ||
                other.providerNotes == providerNotes) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    listingId,
    clientId,
    providerId,
    startDate,
    endDate,
    totalAmount,
    platformFee,
    providerAmount,
    status,
    paymentIntentId,
    specialInstructions,
    meetingLocation,
    clientNotes,
    providerNotes,
    isPaid,
    createdAt,
    updatedAt,
    completedAt,
    cancelledAt,
    cancellationReason,
  ]);

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      __$$BookingImplCopyWithImpl<_$BookingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingImplToJson(this);
  }
}

abstract class _Booking implements Booking {
  const factory _Booking({
    required final String id,
    @JsonKey(name: 'listing_id') required final String listingId,
    @JsonKey(name: 'client_id') required final String clientId,
    @JsonKey(name: 'provider_id') required final String providerId,
    @JsonKey(name: 'start_date') required final DateTime startDate,
    @JsonKey(name: 'end_date') required final DateTime endDate,
    @JsonKey(name: 'total_amount') required final double totalAmount,
    @JsonKey(name: 'platform_fee') required final double platformFee,
    @JsonKey(name: 'provider_amount') required final double providerAmount,
    final BookingStatus status,
    @JsonKey(name: 'payment_intent_id') final String? paymentIntentId,
    @JsonKey(name: 'special_instructions') final String? specialInstructions,
    @JsonKey(name: 'meeting_location') final String? meetingLocation,
    @JsonKey(name: 'client_notes') final String? clientNotes,
    @JsonKey(name: 'provider_notes') final String? providerNotes,
    @JsonKey(name: 'is_paid') final bool isPaid,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    @JsonKey(name: 'completed_at') final DateTime? completedAt,
    @JsonKey(name: 'cancelled_at') final DateTime? cancelledAt,
    @JsonKey(name: 'cancellation_reason') final String? cancellationReason,
  }) = _$BookingImpl;

  factory _Booking.fromJson(Map<String, dynamic> json) = _$BookingImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'listing_id')
  String get listingId;
  @override
  @JsonKey(name: 'client_id')
  String get clientId;
  @override
  @JsonKey(name: 'provider_id')
  String get providerId;
  @override
  @JsonKey(name: 'start_date')
  DateTime get startDate;
  @override
  @JsonKey(name: 'end_date')
  DateTime get endDate;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(name: 'platform_fee')
  double get platformFee;
  @override
  @JsonKey(name: 'provider_amount')
  double get providerAmount;
  @override
  BookingStatus get status;
  @override
  @JsonKey(name: 'payment_intent_id')
  String? get paymentIntentId;
  @override
  @JsonKey(name: 'special_instructions')
  String? get specialInstructions;
  @override
  @JsonKey(name: 'meeting_location')
  String? get meetingLocation;
  @override
  @JsonKey(name: 'client_notes')
  String? get clientNotes;
  @override
  @JsonKey(name: 'provider_notes')
  String? get providerNotes;
  @override
  @JsonKey(name: 'is_paid')
  bool get isPaid;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  @override
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt;
  @override
  @JsonKey(name: 'cancellation_reason')
  String? get cancellationReason;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Application _$ApplicationFromJson(Map<String, dynamic> json) {
  return _Application.fromJson(json);
}

/// @nodoc
mixin _$Application {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'listing_id')
  String get listingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicant_id')
  String get applicantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_letter')
  String? get coverLetter => throw _privateConstructorUsedError;
  @JsonKey(name: 'proposed_rate')
  double? get proposedRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'portfolio_links')
  List<String>? get portfolioLinks => throw _privateConstructorUsedError;
  @JsonKey(name: 'availability_notes')
  String? get availabilityNotes => throw _privateConstructorUsedError;
  ApplicationStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'applied_at')
  DateTime get appliedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_message')
  String? get responseMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'responded_at')
  DateTime? get respondedAt => throw _privateConstructorUsedError;

  /// Serializes this Application to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationCopyWith<Application> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationCopyWith<$Res> {
  factory $ApplicationCopyWith(
    Application value,
    $Res Function(Application) then,
  ) = _$ApplicationCopyWithImpl<$Res, Application>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'listing_id') String listingId,
    @JsonKey(name: 'applicant_id') String applicantId,
    @JsonKey(name: 'cover_letter') String? coverLetter,
    @JsonKey(name: 'proposed_rate') double? proposedRate,
    @JsonKey(name: 'portfolio_links') List<String>? portfolioLinks,
    @JsonKey(name: 'availability_notes') String? availabilityNotes,
    ApplicationStatus status,
    @JsonKey(name: 'applied_at') DateTime appliedAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'response_message') String? responseMessage,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
  });
}

/// @nodoc
class _$ApplicationCopyWithImpl<$Res, $Val extends Application>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? applicantId = null,
    Object? coverLetter = freezed,
    Object? proposedRate = freezed,
    Object? portfolioLinks = freezed,
    Object? availabilityNotes = freezed,
    Object? status = null,
    Object? appliedAt = null,
    Object? updatedAt = null,
    Object? responseMessage = freezed,
    Object? respondedAt = freezed,
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
            applicantId: null == applicantId
                ? _value.applicantId
                : applicantId // ignore: cast_nullable_to_non_nullable
                      as String,
            coverLetter: freezed == coverLetter
                ? _value.coverLetter
                : coverLetter // ignore: cast_nullable_to_non_nullable
                      as String?,
            proposedRate: freezed == proposedRate
                ? _value.proposedRate
                : proposedRate // ignore: cast_nullable_to_non_nullable
                      as double?,
            portfolioLinks: freezed == portfolioLinks
                ? _value.portfolioLinks
                : portfolioLinks // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            availabilityNotes: freezed == availabilityNotes
                ? _value.availabilityNotes
                : availabilityNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ApplicationStatus,
            appliedAt: null == appliedAt
                ? _value.appliedAt
                : appliedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            responseMessage: freezed == responseMessage
                ? _value.responseMessage
                : responseMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApplicationImplCopyWith<$Res>
    implements $ApplicationCopyWith<$Res> {
  factory _$$ApplicationImplCopyWith(
    _$ApplicationImpl value,
    $Res Function(_$ApplicationImpl) then,
  ) = __$$ApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'listing_id') String listingId,
    @JsonKey(name: 'applicant_id') String applicantId,
    @JsonKey(name: 'cover_letter') String? coverLetter,
    @JsonKey(name: 'proposed_rate') double? proposedRate,
    @JsonKey(name: 'portfolio_links') List<String>? portfolioLinks,
    @JsonKey(name: 'availability_notes') String? availabilityNotes,
    ApplicationStatus status,
    @JsonKey(name: 'applied_at') DateTime appliedAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'response_message') String? responseMessage,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
  });
}

/// @nodoc
class __$$ApplicationImplCopyWithImpl<$Res>
    extends _$ApplicationCopyWithImpl<$Res, _$ApplicationImpl>
    implements _$$ApplicationImplCopyWith<$Res> {
  __$$ApplicationImplCopyWithImpl(
    _$ApplicationImpl _value,
    $Res Function(_$ApplicationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? applicantId = null,
    Object? coverLetter = freezed,
    Object? proposedRate = freezed,
    Object? portfolioLinks = freezed,
    Object? availabilityNotes = freezed,
    Object? status = null,
    Object? appliedAt = null,
    Object? updatedAt = null,
    Object? responseMessage = freezed,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _$ApplicationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        listingId: null == listingId
            ? _value.listingId
            : listingId // ignore: cast_nullable_to_non_nullable
                  as String,
        applicantId: null == applicantId
            ? _value.applicantId
            : applicantId // ignore: cast_nullable_to_non_nullable
                  as String,
        coverLetter: freezed == coverLetter
            ? _value.coverLetter
            : coverLetter // ignore: cast_nullable_to_non_nullable
                  as String?,
        proposedRate: freezed == proposedRate
            ? _value.proposedRate
            : proposedRate // ignore: cast_nullable_to_non_nullable
                  as double?,
        portfolioLinks: freezed == portfolioLinks
            ? _value._portfolioLinks
            : portfolioLinks // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        availabilityNotes: freezed == availabilityNotes
            ? _value.availabilityNotes
            : availabilityNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ApplicationStatus,
        appliedAt: null == appliedAt
            ? _value.appliedAt
            : appliedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        responseMessage: freezed == responseMessage
            ? _value.responseMessage
            : responseMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicationImpl implements _Application {
  const _$ApplicationImpl({
    required this.id,
    @JsonKey(name: 'listing_id') required this.listingId,
    @JsonKey(name: 'applicant_id') required this.applicantId,
    @JsonKey(name: 'cover_letter') this.coverLetter,
    @JsonKey(name: 'proposed_rate') this.proposedRate,
    @JsonKey(name: 'portfolio_links') final List<String>? portfolioLinks,
    @JsonKey(name: 'availability_notes') this.availabilityNotes,
    this.status = ApplicationStatus.pending,
    @JsonKey(name: 'applied_at') required this.appliedAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    @JsonKey(name: 'response_message') this.responseMessage,
    @JsonKey(name: 'responded_at') this.respondedAt,
  }) : _portfolioLinks = portfolioLinks;

  factory _$ApplicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'listing_id')
  final String listingId;
  @override
  @JsonKey(name: 'applicant_id')
  final String applicantId;
  @override
  @JsonKey(name: 'cover_letter')
  final String? coverLetter;
  @override
  @JsonKey(name: 'proposed_rate')
  final double? proposedRate;
  final List<String>? _portfolioLinks;
  @override
  @JsonKey(name: 'portfolio_links')
  List<String>? get portfolioLinks {
    final value = _portfolioLinks;
    if (value == null) return null;
    if (_portfolioLinks is EqualUnmodifiableListView) return _portfolioLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'availability_notes')
  final String? availabilityNotes;
  @override
  @JsonKey()
  final ApplicationStatus status;
  @override
  @JsonKey(name: 'applied_at')
  final DateTime appliedAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'response_message')
  final String? responseMessage;
  @override
  @JsonKey(name: 'responded_at')
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'Application(id: $id, listingId: $listingId, applicantId: $applicantId, coverLetter: $coverLetter, proposedRate: $proposedRate, portfolioLinks: $portfolioLinks, availabilityNotes: $availabilityNotes, status: $status, appliedAt: $appliedAt, updatedAt: $updatedAt, responseMessage: $responseMessage, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.applicantId, applicantId) ||
                other.applicantId == applicantId) &&
            (identical(other.coverLetter, coverLetter) ||
                other.coverLetter == coverLetter) &&
            (identical(other.proposedRate, proposedRate) ||
                other.proposedRate == proposedRate) &&
            const DeepCollectionEquality().equals(
              other._portfolioLinks,
              _portfolioLinks,
            ) &&
            (identical(other.availabilityNotes, availabilityNotes) ||
                other.availabilityNotes == availabilityNotes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.responseMessage, responseMessage) ||
                other.responseMessage == responseMessage) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    listingId,
    applicantId,
    coverLetter,
    proposedRate,
    const DeepCollectionEquality().hash(_portfolioLinks),
    availabilityNotes,
    status,
    appliedAt,
    updatedAt,
    responseMessage,
    respondedAt,
  );

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationImplCopyWith<_$ApplicationImpl> get copyWith =>
      __$$ApplicationImplCopyWithImpl<_$ApplicationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationImplToJson(this);
  }
}

abstract class _Application implements Application {
  const factory _Application({
    required final String id,
    @JsonKey(name: 'listing_id') required final String listingId,
    @JsonKey(name: 'applicant_id') required final String applicantId,
    @JsonKey(name: 'cover_letter') final String? coverLetter,
    @JsonKey(name: 'proposed_rate') final double? proposedRate,
    @JsonKey(name: 'portfolio_links') final List<String>? portfolioLinks,
    @JsonKey(name: 'availability_notes') final String? availabilityNotes,
    final ApplicationStatus status,
    @JsonKey(name: 'applied_at') required final DateTime appliedAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    @JsonKey(name: 'response_message') final String? responseMessage,
    @JsonKey(name: 'responded_at') final DateTime? respondedAt,
  }) = _$ApplicationImpl;

  factory _Application.fromJson(Map<String, dynamic> json) =
      _$ApplicationImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'listing_id')
  String get listingId;
  @override
  @JsonKey(name: 'applicant_id')
  String get applicantId;
  @override
  @JsonKey(name: 'cover_letter')
  String? get coverLetter;
  @override
  @JsonKey(name: 'proposed_rate')
  double? get proposedRate;
  @override
  @JsonKey(name: 'portfolio_links')
  List<String>? get portfolioLinks;
  @override
  @JsonKey(name: 'availability_notes')
  String? get availabilityNotes;
  @override
  ApplicationStatus get status;
  @override
  @JsonKey(name: 'applied_at')
  DateTime get appliedAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'response_message')
  String? get responseMessage;
  @override
  @JsonKey(name: 'responded_at')
  DateTime? get respondedAt;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationImplCopyWith<_$ApplicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

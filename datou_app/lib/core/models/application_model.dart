import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

enum ApplicationStatus { pending, accepted, rejected, withdrawn }

@freezed
class Application with _$Application {
  const factory Application({
    required String id,
    @JsonKey(name: 'listing_id') required String listingId,
    @JsonKey(name: 'applicant_id') required String applicantId,
    @JsonKey(name: 'cover_letter') String? coverLetter,
    @JsonKey(name: 'proposed_rate') double? proposedRate,
    @JsonKey(name: 'portfolio_links') List<String>? portfolioLinks,
    @JsonKey(name: 'availability_notes') String? availabilityNotes,
    @Default(ApplicationStatus.pending) ApplicationStatus status,
    @JsonKey(name: 'applied_at') required DateTime appliedAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'response_message') String? responseMessage,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) => _$ApplicationFromJson(json);
}
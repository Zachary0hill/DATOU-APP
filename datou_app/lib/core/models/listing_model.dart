import 'package:freezed_annotation/freezed_annotation.dart';
import '../constants.dart';

part 'listing_model.freezed.dart';
part 'listing_model.g.dart';

enum ListingStatus { draft, active, paused, completed, cancelled }

enum ListingType { photography, videography, modeling, casting }

@freezed
class Listing with _$Listing {
  const factory Listing({
    required String id,
    @JsonKey(name: 'creator_id') required String creatorId,
    required String title,
    required String description,
    required ListingType type,
    @JsonKey(name: 'required_role') UserRole? requiredRole,
    required double budget,
    @JsonKey(name: 'is_negotiable') @Default(true) bool isNegotiable,
    required String location,
    @JsonKey(name: 'event_date') DateTime? eventDate,
    @JsonKey(name: 'event_duration') int? eventDurationHours,
    @JsonKey(name: 'application_deadline') DateTime? applicationDeadline,
    @JsonKey(name: 'required_skills') List<String>? requiredSkills,
    @JsonKey(name: 'preferred_experience') int? preferredExperience,
    @JsonKey(name: 'contact_method') @Default('in_app') String contactMethod,
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
    @Default(ListingStatus.draft) ListingStatus status,
    @JsonKey(name: 'is_urgent') @Default(false) bool isUrgent,
    @JsonKey(name: 'view_count') @Default(0) int viewCount,
    @JsonKey(name: 'application_count') @Default(0) int applicationCount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
  }) = _Listing;

  factory Listing.fromJson(Map<String, dynamic> json) => _$ListingFromJson(json);
}
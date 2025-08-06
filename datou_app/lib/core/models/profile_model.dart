import 'package:freezed_annotation/freezed_annotation.dart';
import '../constants.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'full_name') String? fullName,
    String? username,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    UserRole? role,
    String? location,
    @JsonKey(name: 'travel_radius') int? travelRadius,
    @JsonKey(name: 'hourly_rate') double? hourlyRate,
    @JsonKey(name: 'day_rate') double? dayRate,
    List<String>? skills,
    List<String>? equipment,
    @JsonKey(name: 'years_experience') int? yearsExperience,
    String? website,
    @JsonKey(name: 'instagram_handle') String? instagramHandle,
    @JsonKey(name: 'portfolio_images') List<String>? portfolioImages,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @Default(0.0) double rating,
    @JsonKey(name: 'total_jobs') @Default(0) int totalJobs,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}
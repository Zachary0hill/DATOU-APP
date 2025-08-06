import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_model.freezed.dart';
part 'portfolio_model.g.dart';

enum MediaType { image, video }

@freezed
class Portfolio with _$Portfolio {
  const factory Portfolio({
    required String id,
    @JsonKey(name: 'profile_id') required String profileId,
    required String title,
    String? description,
    @JsonKey(name: 'media_url') required String mediaUrl,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'media_type') required MediaType mediaType,
    List<String>? tags,
    @JsonKey(name: 'shoot_date') DateTime? shootDate,
    String? location,
    @JsonKey(name: 'camera_settings') Map<String, dynamic>? cameraSettings,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'view_count') @Default(0) int viewCount,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Portfolio;

  factory Portfolio.fromJson(Map<String, dynamic> json) => _$PortfolioFromJson(json);
}
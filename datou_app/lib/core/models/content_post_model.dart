import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_post_model.freezed.dart';
part 'content_post_model.g.dart';

@freezed
class ContentPost with _$ContentPost {
  const factory ContentPost({
    required String id,
    required String userId,
    required String username,
    String? userProfileImageUrl,
    required PostType postType,
    
    // Content fields
    required String imageUrl,
    String? videoUrl,
    required String caption,
    List<String>? tags,
    
    // Location
    String? location,
    double? latitude,
    double? longitude,
    
    // Engagement metrics
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    @Default(0) int savesCount,
    @Default(0) int sharesCount,
    @Default([]) List<String> likedByUserIds,
    @Default([]) List<String> savedByUserIds,
    
    // Collaboration/tagging
    @Default([]) List<String> taggedUserIds,
    @Default([]) List<String> taggedUsernames,
    
    // Listing association (if this is a job listing post)
    String? associatedListingId,
    
    // Timestamps
    required DateTime createdAt,
    DateTime? updatedAt,
    
    // Privacy & settings
    @Default(true) bool isPublic,
    @Default(false) bool commentsEnabled,
    @Default(false) bool isPromoted,
    
    // Additional metadata
    Map<String, dynamic>? metadata,
  }) = _ContentPost;

  factory ContentPost.fromJson(Map<String, dynamic> json) =>
      _$ContentPostFromJson(json);
}

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String id,
    required String postId,
    required String userId,
    required String username,
    String? userProfileImageUrl,
    required String text,
    required DateTime createdAt,
    @Default(0) int likesCount,
    @Default([]) List<String> likedByUserIds,
    String? replyToCommentId,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

enum PostType {
  @JsonValue('content')
  content,
  @JsonValue('listing')
  listing,
  @JsonValue('portfolio')
  portfolio,
  @JsonValue('announcement')
  announcement,
}

@freezed
class PostInteraction with _$PostInteraction {
  const factory PostInteraction({
    required String userId,
    required String postId,
    required InteractionType type,
    required DateTime timestamp,
  }) = _PostInteraction;

  factory PostInteraction.fromJson(Map<String, dynamic> json) =>
      _$PostInteractionFromJson(json);
}

enum InteractionType {
  @JsonValue('like')
  like,
  @JsonValue('save')
  save,
  @JsonValue('share')
  share,
  @JsonValue('comment')
  comment,
}

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/content_post_model.dart';

class ContentRepository {
  final SupabaseClient _supabase;

  ContentRepository(this._supabase);

  // Fetch feed posts (paginated)
  Future<List<ContentPost>> getFeedPosts({
    int limit = 20,
    int offset = 0,
    String? userId,
    PostType? postType,
  }) async {
    try {
      // Apply filters first (must be on FilterBuilder), then transforms like order/range
      var query = _supabase.from('content_posts').select();

      if (userId != null) {
        query = query.eq('user_id', userId);
      }

      if (postType != null) {
        query = query.eq('post_type', postType.name);
      }

      // Pagination using range (offset inclusive, to inclusive)
      final end = offset + limit - 1;
      final response = await query
          .order('created_at', ascending: false)
          .range(offset, end);
      
      return (response as List)
          .map((json) => ContentPost.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch feed posts: $e');
    }
  }

  // Get posts for a specific user
  Future<List<ContentPost>> getUserPosts(String userId) async {
    try {
      final response = await _supabase
          .from('content_posts')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => ContentPost.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch user posts: $e');
    }
  }

  // Get a single post
  Future<ContentPost?> getPost(String postId) async {
    try {
      final response = await _supabase
          .from('content_posts')
          .select()
          .eq('id', postId)
          .single();

      return ContentPost.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Create a new post
  Future<ContentPost> createPost(ContentPost post) async {
    try {
      final response = await _supabase
          .from('content_posts')
          .insert(post.toJson())
          .select()
          .single();

      return ContentPost.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // Update a post
  Future<ContentPost> updatePost(String postId, Map<String, dynamic> updates) async {
    try {
      final response = await _supabase
          .from('content_posts')
          .update(updates)
          .eq('id', postId)
          .select()
          .single();

      return ContentPost.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    try {
      await _supabase
          .from('content_posts')
          .delete()
          .eq('id', postId);
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }

  // Like/Unlike a post
  Future<void> toggleLike(String postId, String userId) async {
    try {
      final post = await getPost(postId);
      if (post == null) throw Exception('Post not found');

      final isLiked = post.likedByUserIds.contains(userId);
      final updatedLikes = List<String>.from(post.likedByUserIds);
      
      if (isLiked) {
        updatedLikes.remove(userId);
      } else {
        updatedLikes.add(userId);
      }

      await updatePost(postId, {
        'liked_by_user_ids': updatedLikes,
        'likes_count': updatedLikes.length,
      });

      // Record interaction
      if (!isLiked) {
        await _supabase.from('post_interactions').insert({
          'user_id': userId,
          'post_id': postId,
          'type': InteractionType.like.name,
          'timestamp': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Failed to toggle like: $e');
    }
  }

  // Save/Unsave a post
  Future<void> toggleSave(String postId, String userId) async {
    try {
      final post = await getPost(postId);
      if (post == null) throw Exception('Post not found');

      final isSaved = post.savedByUserIds.contains(userId);
      final updatedSaves = List<String>.from(post.savedByUserIds);
      
      if (isSaved) {
        updatedSaves.remove(userId);
      } else {
        updatedSaves.add(userId);
      }

      await updatePost(postId, {
        'saved_by_user_ids': updatedSaves,
        'saves_count': updatedSaves.length,
      });

      // Record interaction
      if (!isSaved) {
        await _supabase.from('post_interactions').insert({
          'user_id': userId,
          'post_id': postId,
          'type': InteractionType.save.name,
          'timestamp': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Failed to toggle save: $e');
    }
  }

  // Get comments for a post
  Future<List<Comment>> getComments(String postId) async {
    try {
      final response = await _supabase
          .from('comments')
          .select()
          .eq('post_id', postId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Comment.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }

  // Add a comment
  Future<Comment> addComment(Comment comment) async {
    try {
      final response = await _supabase
          .from('comments')
          .insert(comment.toJson())
          .select()
          .single();

      // Update comment count
      final post = await getPost(comment.postId);
      if (post != null) {
        await updatePost(comment.postId, {
          'comments_count': post.commentsCount + 1,
        });
      }

      // Record interaction
      await _supabase.from('post_interactions').insert({
        'user_id': comment.userId,
        'post_id': comment.postId,
        'type': InteractionType.comment.name,
        'timestamp': DateTime.now().toIso8601String(),
      });

      return Comment.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }

  // Delete a comment
  Future<void> deleteComment(String commentId, String postId) async {
    try {
      await _supabase
          .from('comments')
          .delete()
          .eq('id', commentId);

      // Update comment count
      final post = await getPost(postId);
      if (post != null) {
        await updatePost(postId, {
          'comments_count': post.commentsCount - 1,
        });
      }
    } catch (e) {
      throw Exception('Failed to delete comment: $e');
    }
  }

  // Get saved posts for a user
  Future<List<ContentPost>> getSavedPosts(String userId) async {
    try {
      final response = await _supabase
          .from('content_posts')
          .select()
          .contains('saved_by_user_ids', [userId])
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => ContentPost.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch saved posts: $e');
    }
  }

  // Search posts
  Future<List<ContentPost>> searchPosts(String query) async {
    try {
      final response = await _supabase
          .from('content_posts')
          .select()
          .or('caption.ilike.%$query%,tags.ilike.%$query%')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => ContentPost.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to search posts: $e');
    }
  }
}

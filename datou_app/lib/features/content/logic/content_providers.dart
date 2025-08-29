import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/content_post_model.dart';
import '../data/content_repository.dart';

// Repository provider
final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  final supabase = Supabase.instance.client;
  return ContentRepository(supabase);
});

// Feed posts provider with pagination
final feedPostsProvider = StateNotifierProvider<FeedPostsNotifier, AsyncValue<List<ContentPost>>>((ref) {
  return FeedPostsNotifier(ref.watch(contentRepositoryProvider));
});

class FeedPostsNotifier extends StateNotifier<AsyncValue<List<ContentPost>>> {
  final ContentRepository _repository;
  int _currentOffset = 0;
  static const int _pageSize = 20;
  bool _hasMore = true;
  PostType? _filterType;

  FeedPostsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadInitialPosts();
  }

  Future<void> loadInitialPosts() async {
    state = const AsyncValue.loading();
    try {
      _currentOffset = 0;
      final posts = await _repository.getFeedPosts(
        limit: _pageSize,
        offset: 0,
        postType: _filterType,
      );
      _hasMore = posts.length == _pageSize;
      state = AsyncValue.data(posts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMorePosts() async {
    if (!_hasMore || state.isLoading) return;

    final currentPosts = state.value ?? [];
    try {
      _currentOffset += _pageSize;
      final newPosts = await _repository.getFeedPosts(
        limit: _pageSize,
        offset: _currentOffset,
        postType: _filterType,
      );
      
      _hasMore = newPosts.length == _pageSize;
      state = AsyncValue.data([...currentPosts, ...newPosts]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refreshPosts() async {
    await loadInitialPosts();
  }

  void setFilter(PostType? type) {
    _filterType = type;
    loadInitialPosts();
  }

  void updatePost(ContentPost updatedPost) {
    state.whenData((posts) {
      final index = posts.indexWhere((p) => p.id == updatedPost.id);
      if (index != -1) {
        final updatedPosts = [...posts];
        updatedPosts[index] = updatedPost;
        state = AsyncValue.data(updatedPosts);
      }
    });
  }

  void removePost(String postId) {
    state.whenData((posts) {
      state = AsyncValue.data(posts.where((p) => p.id != postId).toList());
    });
  }

  void addPost(ContentPost newPost) {
    state.whenData((posts) {
      state = AsyncValue.data([newPost, ...posts]);
    });
  }
}

// User posts provider
final userPostsProvider = FutureProvider.family<List<ContentPost>, String>((ref, userId) async {
  final repository = ref.watch(contentRepositoryProvider);
  return repository.getUserPosts(userId);
});

// Single post provider
final postProvider = FutureProvider.family<ContentPost?, String>((ref, postId) async {
  final repository = ref.watch(contentRepositoryProvider);
  return repository.getPost(postId);
});

// Comments provider
final commentsProvider = FutureProvider.family<List<Comment>, String>((ref, postId) async {
  final repository = ref.watch(contentRepositoryProvider);
  return repository.getComments(postId);
});

// Saved posts provider
final savedPostsProvider = FutureProvider.family<List<ContentPost>, String>((ref, userId) async {
  final repository = ref.watch(contentRepositoryProvider);
  return repository.getSavedPosts(userId);
});

// Search posts provider
final searchPostsProvider = FutureProvider.family<List<ContentPost>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final repository = ref.watch(contentRepositoryProvider);
  return repository.searchPosts(query);
});

// Post interaction providers
final toggleLikeProvider = Provider((ref) {
  final repository = ref.watch(contentRepositoryProvider);
  return (String postId, String userId) async {
    await repository.toggleLike(postId, userId);
    // Refresh the post in the feed
    final feedNotifier = ref.read(feedPostsProvider.notifier);
    final updatedPost = await repository.getPost(postId);
    if (updatedPost != null) {
      feedNotifier.updatePost(updatedPost);
    }
  };
});

final toggleSaveProvider = Provider((ref) {
  final repository = ref.watch(contentRepositoryProvider);
  return (String postId, String userId) async {
    await repository.toggleSave(postId, userId);
    // Refresh the post in the feed
    final feedNotifier = ref.read(feedPostsProvider.notifier);
    final updatedPost = await repository.getPost(postId);
    if (updatedPost != null) {
      feedNotifier.updatePost(updatedPost);
    }
  };
});

final addCommentProvider = Provider((ref) {
  final repository = ref.watch(contentRepositoryProvider);
  return (Comment comment) async {
    final newComment = await repository.addComment(comment);
    // Refresh comments
    ref.invalidate(commentsProvider(comment.postId));
    // Update post comment count
    final feedNotifier = ref.read(feedPostsProvider.notifier);
    final updatedPost = await repository.getPost(comment.postId);
    if (updatedPost != null) {
      feedNotifier.updatePost(updatedPost);
    }
    return newComment;
  };
});

// Create post provider
final createPostProvider = Provider((ref) {
  final repository = ref.watch(contentRepositoryProvider);
  return (ContentPost post) async {
    final newPost = await repository.createPost(post);
    // Add to feed
    ref.read(feedPostsProvider.notifier).addPost(newPost);
    return newPost;
  };
});

// Delete post provider
final deletePostProvider = Provider((ref) {
  final repository = ref.watch(contentRepositoryProvider);
  return (String postId) async {
    await repository.deletePost(postId);
    // Remove from feed
    ref.read(feedPostsProvider.notifier).removePost(postId);
  };
});

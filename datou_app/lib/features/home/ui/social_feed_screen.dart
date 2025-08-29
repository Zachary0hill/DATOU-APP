import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/content_post_model.dart';
import '../../content/logic/content_providers.dart';
import '../../auth/logic/auth_providers.dart';
import 'package:intl/intl.dart';
import 'reel_video_player.dart';

class SocialFeedScreen extends ConsumerStatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  ConsumerState<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends ConsumerState<SocialFeedScreen> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _activePage = 0;
  final List<String> _demoVideos = const [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(feedPostsProvider.notifier).loadMorePosts();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedPosts = ref.watch(feedPostsProvider);
    final currentUser = ref.watch(currentUserProvider);
    final isGuest = ref.watch(guestModeProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Near you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to create post
              if (isGuest) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sign up to create posts!'),
                  ),
                );
              } else {
                // Navigate to create post screen
                context.push('/create-post');
              }
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Show notifications
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications coming soon!'),
                ),
              );
            },
            icon: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: feedPosts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return _buildDemoReels();
          }

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: posts.length,
            onPageChanged: (index) {
              // Load more when near the end
              if (index >= posts.length - 3) {
                ref.read(feedPostsProvider.notifier).loadMorePosts();
              }
              setState(() {
                _activePage = index;
              });
            },
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostView(
                post: post,
                currentUserId: currentUser?.id,
                isGuest: isGuest,
                isActive: _activePage == index,
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        error: (error, stack) => _buildDemoReels(showErrorBanner: true),
      ),
    );
  }

  Widget _buildDemoReels({bool showErrorBanner = false}) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _demoVideos.length,
          onPageChanged: (index) {
            setState(() {
              _activePage = index;
            });
          },
          itemBuilder: (context, index) {
            final url = _demoVideos[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                ReelVideoPlayer(url: url, isActive: _activePage == index),
                Positioned(
                  bottom: 80,
                  left: 16,
                  child: Text(
                    'Demo Reel ${index + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
        if (showErrorBanner)
          Positioned(
            top: MediaQuery.of(context).padding.top + 48,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Showing demo reels (feed error)',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class PostView extends ConsumerWidget {
  final ContentPost post;
  final String? currentUserId;
  final bool isGuest;
  final bool isActive;

  const PostView({
    super.key,
    required this.post,
    this.currentUserId,
    required this.isGuest,
    required this.isActive,
  });

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = currentUserId != null && post.likedByUserIds.contains(currentUserId);
    final isSaved = currentUserId != null && post.savedByUserIds.contains(currentUserId);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Main content image/video
        GestureDetector(
          onDoubleTap: () {
            if (!isGuest && currentUserId != null) {
              ref.read(toggleLikeProvider)(post.id, currentUserId!);
            }
          },
          child: post.videoUrl != null && post.videoUrl!.isNotEmpty
              ? ReelVideoPlayer(url: post.videoUrl!, isActive: isActive)
              : CachedNetworkImage(
                  imageUrl: post.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[900],
                    child: const Icon(
                      Icons.error,
                      color: Colors.white54,
                    ),
                  ),
                ),
        ),

        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.0, 0.5, 0.8, 1.0],
            ),
          ),
        ),

        // Content overlay
        Positioned(
          left: 16,
          right: 72,
          bottom: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location and tagged users
              if (post.location != null || post.taggedUsernames.isNotEmpty) ...[
                Row(
                  children: [
                    if (post.location != null) ...[
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.location!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                    if (post.location != null && post.taggedUsernames.isNotEmpty)
                      const SizedBox(width: 16),
                    if (post.taggedUsernames.isNotEmpty) ...[
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'With ${post.taggedUsernames.length} ${post.taggedUsernames.length == 1 ? 'other' : 'others'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
              ],

              // Username and follow button
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: post.userProfileImageUrl != null
                        ? CachedNetworkImageProvider(post.userProfileImageUrl!)
                        : null,
                    child: post.userProfileImageUrl == null
                        ? const Icon(Icons.person, size: 20)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    post.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (post.userId != currentUserId) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 16,
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Follow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 8),

              // Caption
              if (post.caption.isNotEmpty) ...[
                Text(
                  post.caption,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),

        // Right side actions
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            children: [
              // Like button
              _ActionButton(
                icon: isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.white,
                label: _formatNumber(post.likesCount),
                onTap: () {
                  if (!isGuest && currentUserId != null) {
                    ref.read(toggleLikeProvider)(post.id, currentUserId!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign up to like posts!'),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              // Comment button
              _ActionButton(
                icon: Icons.mode_comment_outlined,
                color: Colors.white,
                label: post.commentsCount > 0 
                    ? '[${_formatNumber(post.commentsCount)}]'
                    : '[${_formatNumber(post.commentsCount)}]',
                onTap: () {
                  // Show comments sheet
                  _showCommentsSheet(context, ref, post);
                },
              ),
              const SizedBox(height: 20),

              // Save button
              _ActionButton(
                icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved ? Colors.yellow : Colors.white,
                onTap: () {
                  if (!isGuest && currentUserId != null) {
                    ref.read(toggleSaveProvider)(post.id, currentUserId!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign up to save posts!'),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              // Share button
              _ActionButton(
                icon: Icons.share_outlined,
                color: Colors.white,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sharing coming soon!'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // More options
              _ActionButton(
                icon: Icons.more_horiz,
                color: Colors.white,
                onTap: () {
                  _showMoreOptions(context, ref, post);
                },
              ),
            ],
          ),
        ),

        // User avatar for quick profile access
        Positioned(
          right: 16,
          bottom: 420,
          child: GestureDetector(
            onTap: () {
              // Navigate to user profile
              context.push('/profile/${post.userId}');
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: post.userProfileImageUrl != null
                        ? CachedNetworkImageProvider(post.userProfileImageUrl!)
                        : null,
                    child: post.userProfileImageUrl == null
                        ? const Icon(Icons.person, size: 24)
                        : null,
                  ),
                ),
                if (post.userId != currentUserId)
                  Transform.translate(
                    offset: const Offset(0, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCommentsSheet(BuildContext context, WidgetRef ref, ContentPost post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${post.commentsCount} Comments',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final commentsAsync = ref.watch(commentsProvider(post.id));
                    return commentsAsync.when(
                      data: (comments) => ListView.builder(
                        controller: scrollController,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: comment.userProfileImageUrl != null
                                  ? CachedNetworkImageProvider(comment.userProfileImageUrl!)
                                  : null,
                              child: comment.userProfileImageUrl == null
                                  ? const Icon(Icons.person, size: 20)
                                  : null,
                            ),
                            title: Row(
                              children: [
                                Text(
                                  comment.username,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat.yMMMd().format(comment.createdAt),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(comment.text),
                          );
                        },
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Text('Error loading comments: $error'),
                      ),
                    );
                  },
                ),
              ),
              if (!isGuest)
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    top: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          onSubmitted: (text) {
                            // Add comment logic
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          // Send comment
                        },
                        icon: const Icon(Icons.send, color: kPrimary),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context, WidgetRef ref, ContentPost post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (post.userId == currentUserId) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Post'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to edit
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Post', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  // Show delete confirmation
                },
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Report Post'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report submitted')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Block User'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User blocked')),
                  );
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Copy Link'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link copied!')),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String? label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          if (label != null) ...[
            const SizedBox(height: 4),
            Text(
              label!,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

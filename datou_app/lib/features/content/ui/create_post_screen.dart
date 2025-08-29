import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/content_post_model.dart';
import '../logic/content_providers.dart';
import '../../auth/logic/auth_providers.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _captionController = TextEditingController();
  final _locationController = TextEditingController();
  final _tagController = TextEditingController();
  final List<String> _tags = [];
  File? _selectedImage;
  File? _selectedVideo;
  PostType _selectedPostType = PostType.content;
  bool _isPublic = true;
  bool _commentsEnabled = true;
  bool _isPosting = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _captionController.dispose();
    _locationController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? video = await _picker.pickVideo(source: source, maxDuration: const Duration(minutes: 2));
    if (video != null) {
      setState(() {
        _selectedVideo = File(video.path);
        _selectedImage = null; // prefer video over image
      });
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  Future<void> _createPost() async {
    if (_selectedImage == null && _selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image or video')),
      );
      return;
    }

    if (_captionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a caption')),
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    try {
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) {
        throw Exception('User not logged in');
      }

      // TODO: Upload media to storage and get URLs
      // For now, use placeholders so the feed can render videos/images
      const imageUrl = 'https://picsum.photos/800/1200';
      final videoUrl = _selectedVideo != null
          ? 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
          : null;

      final post = ContentPost(
        id: const Uuid().v4(),
        userId: currentUser.id,
        username: currentUser.userMetadata?['username'] ?? 'Anonymous',
        userProfileImageUrl: currentUser.userMetadata?['avatar_url'],
        postType: _selectedPostType,
        imageUrl: imageUrl,
        videoUrl: videoUrl,
        caption: _captionController.text.trim(),
        tags: _tags,
        location: _locationController.text.trim().isEmpty 
            ? null 
            : _locationController.text.trim(),
        createdAt: DateTime.now(),
        isPublic: _isPublic,
        commentsEnabled: _commentsEnabled,
      );

      await ref.read(createPostProvider)(post);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post created successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating post: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPosting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const Text(
                    'Create Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: _isPosting ? null : _createPost,
                    child: _isPosting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Share',
                            style: TextStyle(
                              color: Color(0xFF8B5CF6),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            // Post Type Selector
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Post Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _PostTypeChip(
                        label: 'Content',
                        icon: Icons.photo,
                        isSelected: _selectedPostType == PostType.content,
                        onTap: () {
                          setState(() {
                            _selectedPostType = PostType.content;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _PostTypeChip(
                        label: 'Job Listing',
                        icon: Icons.work,
                        isSelected: _selectedPostType == PostType.listing,
                        onTap: () {
                          setState(() {
                            _selectedPostType = PostType.listing;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _PostTypeChip(
                        label: 'Portfolio',
                        icon: Icons.folder,
                        isSelected: _selectedPostType == PostType.portfolio,
                        onTap: () {
                          setState(() {
                            _selectedPostType = PostType.portfolio;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Image Selection
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Take Photo'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.camera);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Choose Photo from Library'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.gallery);
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.videocam),
                          title: const Text('Record Video'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickVideo(ImageSource.camera);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.video_library),
                          title: const Text('Choose Video from Library'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickVideo(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: Border.all(
                    color: Colors.grey[800]!,
                    width: 1,
                  ),
                ),
                child: _selectedVideo != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          const Center(
                            child: Icon(Icons.videocam, color: Colors.white70, size: 80),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedVideo = null;
                                });
                              },
                              icon: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : _selectedImage != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                              },
                              icon: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            size: 80,
                            color: Colors.white54,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Tap to add photo',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // Caption
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _captionController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: _selectedPostType == PostType.listing
                      ? 'Describe the job opportunity...'
                      : 'Write a caption...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),

            Divider(height: 1, color: Colors.grey[800]),

            // Location
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.white70),
              title: TextField(
                controller: _locationController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Add location',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: InputBorder.none,
                ),
              ),
              trailing: _locationController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _locationController.clear();
                        });
                      },
                      icon: const Icon(Icons.clear, size: 20, color: Colors.white70),
                    )
                  : null,
            ),

            Divider(height: 1, color: Colors.grey[800]),

            // Tags
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _tagController,
                          decoration: const InputDecoration(
                            hintText: 'Add tags (e.g., fashion, portrait)',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.tag),
                          ),
                          onSubmitted: (_) => _addTag(),
                        ),
                      ),
                      TextButton(
                        onPressed: _addTag,
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                  if (_tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _tags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () => _removeTag(tag),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),

            const Divider(height: 1),

            // Privacy Settings
            SwitchListTile(
              title: const Text('Public Post'),
              subtitle: const Text('Anyone can see this post'),
              value: _isPublic,
              onChanged: (value) {
                setState(() {
                  _isPublic = value;
                });
              },
            ),

            SwitchListTile(
              title: const Text('Enable Comments'),
              subtitle: const Text('Allow others to comment'),
              value: _commentsEnabled,
              onChanged: (value) {
                setState(() {
                  _commentsEnabled = value;
                });
              },
            ),

            // Job-specific fields (if listing)
            if (_selectedPostType == PostType.listing) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Job Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Rate/Budget',
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Duration',
                        prefixIcon: const Icon(Icons.schedule),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Requirements',
                        prefixIcon: const Icon(Icons.checklist),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PostTypeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? kPrimary : Colors.grey[600]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

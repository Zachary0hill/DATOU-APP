import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../auth/logic/auth_providers.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  bool _saving = false;
  Uint8List? _avatarBytes;
  String? _avatarUrlPreview;

  @override
  void initState() {
    super.initState();
    final user = ref.read(currentUserProvider);
    _nameController.text = user?.userMetadata?['name']?.toString() ?? '';
    _usernameController.text = user?.userMetadata?['username']?.toString() ?? '';
    _bioController.text = user?.userMetadata?['bio']?.toString() ?? '';
    _websiteController.text = user?.userMetadata?['website']?.toString() ?? '';
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1024, maxHeight: 1024, imageQuality: 85);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    setState(() {
      _avatarBytes = bytes;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final user = ref.read(currentUserProvider);
      if (_avatarBytes != null && user != null) {
        final url = await ref.read(authRepositoryProvider)
            .uploadAvatarBytes(bytes: _avatarBytes!, userId: user.id);
        _avatarUrlPreview = url;
      }
      final metadata = <String, dynamic>{
        'name': _nameController.text.trim(),
        'username': _usernameController.text.trim(),
        'bio': _bioController.text.trim(),
        'website': _websiteController.text.trim(),
        if (_avatarUrlPreview != null) 'avatar_url': _avatarUrlPreview,
      };

      // Remove empty values
      metadata.removeWhere((key, value) => (value is String) && value.isEmpty);

      await ref.read(authRepositoryProvider).updateUserMetadata(metadata);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text('Details', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Done'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickAvatar,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white12,
                        backgroundImage: _avatarBytes != null
                            ? MemoryImage(_avatarBytes!)
                            : (ref.watch(currentUserProvider)?.userMetadata?['avatar_url'] != null
                                ? NetworkImage(ref.watch(currentUserProvider)!.userMetadata!['avatar_url'] as String) as ImageProvider
                                : null),
                        child: (_avatarBytes == null && (ref.watch(currentUserProvider)?.userMetadata?['avatar_url'] == null))
                            ? const Icon(Icons.person, color: Colors.white54, size: 44)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          _SectionHeader('About'),
          const SizedBox(height: 8),
          _EditRow(label: 'Name', child: _buildTextField(_nameController, hint: 'Your name')),
          _Divider(),
          _EditRow(label: 'Username', child: _buildTextField(_usernameController, hint: 'username')),
          _Divider(),
          _EditRow(label: 'Bio', child: _buildTextField(_bioController, hint: 'Tell people about you', maxLines: 3)),
          _Divider(),
          _EditRow(label: 'Website', child: _buildTextField(_websiteController, hint: 'https://example.com')),
          const SizedBox(height: 24),
          _SectionHeader('Public business information'),
          const SizedBox(height: 8),
          // Placeholders for future fields
          _StaticRow(label: 'Category', value: '—'),
          _Divider(),
          _StaticRow(label: 'Address', value: '—'),
          _Divider(),
          _StaticRow(label: 'Phone', value: '—'),
          _Divider(),
          _StaticRow(label: 'Email', value: ref.watch(currentUserProvider)?.email ?? '—'),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {String? hint, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _EditRow extends StatelessWidget {
  const _EditRow({required this.label, required this.child});
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 96,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: child),
      ],
    );
  }
}

class _StaticRow extends StatelessWidget {
  const _StaticRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.white12, height: 24);
  }
}



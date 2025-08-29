import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/models/models.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_sections.dart';

class PhotographerSetupScreen extends StatefulWidget {
  const PhotographerSetupScreen({super.key});

  @override
  State<PhotographerSetupScreen> createState() => _PhotographerSetupScreenState();
}

class _PhotographerSetupScreenState extends State<PhotographerSetupScreen> {
  final TextEditingController nicheController = TextEditingController();
  double radiusMiles = 25;
  double years = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Photographer Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Niche', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: nicheController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                hintText: 'e.g. Portraits, Weddings',
              ),
            ),
            const SizedBox(height: 16),
            Text('Service radius: ${radiusMiles.toStringAsFixed(0)} mi', style: const TextStyle(color: Colors.white70)),
            Slider(
              value: radiusMiles,
              min: 5,
              max: 200,
              divisions: 39,
              label: radiusMiles.toStringAsFixed(0),
              onChanged: (v) => setState(() => radiusMiles = v),
            ),
            const SizedBox(height: 8),
            Text('Years experience: ${years.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white70)),
            Slider(
              value: years,
              min: 0,
              max: 40,
              divisions: 40,
              label: years.toStringAsFixed(0),
              onChanged: (v) => setState(() => years = v),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C5CFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  context.go('/terms');
                },
                child: const Text('Continue', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhotographerProfilePage extends ConsumerWidget {
  const PhotographerProfilePage({
    required this.profile,
    this.isOwnProfile = false,
    super.key,
  });

  final Profile profile;
  final bool isOwnProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(
              profile: profile,
              showEditButton: isOwnProfile,
              onEditPressed: () {
                // TODO: Navigate to edit profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit profile coming soon!')),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                
                // About Section
                AboutSection(profile: profile),
                
                // Photography Specialties
                SkillsSection(
                  skills: profile.skills,
                  title: 'Photography Specialties',
                ),
                
                // Equipment
                SkillsSection(
                  skills: profile.equipment,
                  title: 'Equipment & Gear',
                ),
                
                // Rates
                RatesSection(profile: profile),
                
                // Portfolio
                PortfolioSection(portfolioImages: profile.portfolioImages),
                
                // Photography-specific sections
                _buildPhotographyStylesSection(),
                _buildServicesSection(),
                
                const SizedBox(height: 100), // Space for contact buttons
              ],
            ),
          ),
        ],
      ),
      bottomSheet: isOwnProfile
          ? null
          : ContactSection(
              onMessagePressed: () {
                // TODO: Open chat
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Messaging coming soon!')),
                );
              },
              onBookPressed: () {
                // TODO: Open booking flow
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Booking coming soon!')),
                );
              },
            ),
    );
  }

  Widget _buildPhotographyStylesSection() {
    final photographyStyles = [
      'Portrait',
      'Wedding',
      'Event',
      'Commercial',
      'Fashion',
      'Landscape',
      'Street Photography',
      'Product Photography',
    ];

    // Filter based on profile skills if available
    final relevantStyles = profile.skills
            ?.where((skill) => photographyStyles.any(
                (style) => style.toLowerCase().contains(skill.toLowerCase())))
            .toList() ??
        [];

    if (relevantStyles.isEmpty) return const SizedBox.shrink();

    return ProfileSection(
      title: 'Photography Styles',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: relevantStyles.map((style) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Text(
              style,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildServicesSection() {
    final services = [
      ServiceItem(
        icon: Icons.camera_alt,
        title: 'Photo Sessions',
        description: 'Professional photography sessions',
      ),
      ServiceItem(
        icon: Icons.edit,
        title: 'Photo Editing',
        description: 'Post-processing and retouching',
      ),
      ServiceItem(
        icon: Icons.print,
        title: 'Prints & Albums',
        description: 'High-quality prints and photo albums',
      ),
      ServiceItem(
        icon: Icons.event,
        title: 'Event Coverage',
        description: 'Weddings, parties, and corporate events',
      ),
    ];

    return ProfileSection(
      title: 'Services Offered',
      child: Column(
        children: services.map((service) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(service.icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        service.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ServiceItem {
  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
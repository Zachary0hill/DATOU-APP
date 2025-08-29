import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/models/models.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_sections.dart';

class VideographerSetupScreen extends StatefulWidget {
  const VideographerSetupScreen({super.key});

  @override
  State<VideographerSetupScreen> createState() => _VideographerSetupScreenState();
}

class _VideographerSetupScreenState extends State<VideographerSetupScreen> {
  final TextEditingController nicheController = TextEditingController();
  double years = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Videographer Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Specialty', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: nicheController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                hintText: 'e.g. Weddings, Commercial',
              ),
            ),
            const SizedBox(height: 16),
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

class VideographerProfilePage extends ConsumerWidget {
  const VideographerProfilePage({
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
                
                // Video Specialties
                SkillsSection(
                  skills: profile.skills,
                  title: 'Video Specialties',
                ),
                
                // Equipment
                SkillsSection(
                  skills: profile.equipment,
                  title: 'Camera & Audio Equipment',
                ),
                
                // Rates
                RatesSection(profile: profile),
                
                // Video Production Styles
                _buildVideoStylesSection(),
                
                // Portfolio (Video Reel)
                _buildVideoPortfolioSection(),
                
                // Services
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

  Widget _buildVideoStylesSection() {
    final videoStyles = [
      'Wedding Films',
      'Corporate Videos',
      'Music Videos',
      'Documentaries',
      'Commercial Ads',
      'Event Coverage',
      'Social Media Content',
      'Training Videos',
    ];

    // Filter based on profile skills if available
    final relevantStyles = profile.skills
            ?.where((skill) => videoStyles.any(
                (style) => style.toLowerCase().contains(skill.toLowerCase())))
            .toList() ??
        [];

    if (relevantStyles.isEmpty) return const SizedBox.shrink();

    return ProfileSection(
      title: 'Video Production Styles',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: relevantStyles.map((style) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Text(
              style,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVideoPortfolioSection() {
    return ProfileSection(
      title: 'Video Portfolio',
      action: TextButton(
        onPressed: () {
          // TODO: Navigate to full video portfolio
        },
        child: const Text('View All'),
      ),
      child: profile.portfolioImages?.isNotEmpty == true
          ? Column(
              children: [
                // Video thumbnails with play buttons
                GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 16 / 9,
                  ),
                  itemCount: profile.portfolioImages!.length > 4 
                      ? 4 
                      : profile.portfolioImages!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.video_library,
                              size: 32,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.play_circle_filled,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.videocam, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Demo Reel Available',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Watch →',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container(
              padding: const EdgeInsets.all(32),
              child: const Center(
                child: Column(
                  children: [
                    Icon(Icons.videocam_off, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No video portfolio yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildServicesSection() {
    final services = [
      ServiceItem(
        icon: Icons.videocam,
        title: 'Video Production',
        description: 'Full-service video production from concept to delivery',
      ),
      ServiceItem(
        icon: Icons.edit,
        title: 'Video Editing',
        description: 'Post-production editing and color correction',
      ),
      ServiceItem(
        icon: Icons.music_note,
        title: 'Audio Production',
        description: 'Sound design and audio mixing',
      ),
      ServiceItem(
        icon: Icons.live_tv,
        title: 'Live Streaming',
        description: 'Live event streaming and broadcasting',
      ),
      ServiceItem(
        icon: Icons.theater_comedy,
        title: 'Motion Graphics',
        description: 'Animated graphics and visual effects',
      ),
      ServiceItem(
        icon: Icons.cloud_upload,
        title: 'Content Distribution',
        description: 'Platform optimization and content delivery',
      ),
    ];

    return ProfileSection(
      title: 'Video Services',
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
                    color: Colors.red,
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
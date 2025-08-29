import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/models/models.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_sections.dart';

class ModelSetupScreen extends StatefulWidget {
  const ModelSetupScreen({super.key});

  @override
  State<ModelSetupScreen> createState() => _ModelSetupScreenState();
}

class _ModelSetupScreenState extends State<ModelSetupScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Model Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Height', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                hintText: 'e.g. 5\'11"',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Weight', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                hintText: 'e.g. 160 lb',
              ),
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

class ModelProfilePage extends ConsumerWidget {
  const ModelProfilePage({
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
                
                // Physical Stats
                _buildPhysicalStatsSection(),
                
                // Modeling Specialties
                SkillsSection(
                  skills: profile.skills,
                  title: 'Modeling Specialties',
                ),
                
                // Experience Types
                _buildExperienceTypesSection(),
                
                // Rates
                RatesSection(profile: profile),
                
                // Portfolio
                PortfolioSection(portfolioImages: profile.portfolioImages),
                
                // Measurements & Details
                _buildMeasurementsSection(),
                
                // Availability
                _buildAvailabilitySection(),
                
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

  Widget _buildPhysicalStatsSection() {
    // This would typically come from additional profile fields
    // For demo purposes, showing placeholder data
    return ProfileSection(
      title: 'Physical Stats',
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard('Height', '5\'8"', Icons.height),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Hair', 'Brown', Icons.face),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Eyes', 'Blue', Icons.remove_red_eye),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.purple, size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTypesSection() {
    final experienceTypes = [
      'Fashion',
      'Commercial',
      'Editorial',
      'Runway',
      'Fitness',
      'Lingerie',
      'Art/Nude',
      'Lifestyle',
      'Beauty',
      'Headshots',
    ];

    // Filter based on profile skills if available
    final relevantTypes = profile.skills
            ?.where((skill) => experienceTypes.any(
                (type) => type.toLowerCase().contains(skill.toLowerCase())))
            .toList() ??
        [];

    if (relevantTypes.isEmpty) return const SizedBox.shrink();

    return ProfileSection(
      title: 'Modeling Experience',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: relevantTypes.map((type) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.purple.withOpacity(0.3)),
            ),
            child: Text(
              type,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.purple,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMeasurementsSection() {
    // This would typically come from additional profile fields
    return ProfileSection(
      title: 'Professional Details',
      child: Column(
        children: [
          _buildDetailRow('Dress Size', 'Size 6'),
          _buildDetailRow('Shoe Size', '8.5'),
          _buildDetailRow('Tattoos', 'None'),
          _buildDetailRow('Piercings', 'Ears only'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilitySection() {
    final availabilityTypes = [
      AvailabilityItem(
        icon: Icons.airplanemode_active,
        title: 'Travel',
        description: 'Available for travel assignments',
        available: true,
      ),
      AvailabilityItem(
        icon: Icons.weekend,
        title: 'Weekends',
        description: 'Available for weekend shoots',
        available: true,
      ),
      AvailabilityItem(
        icon: Icons.nights_stay,
        title: 'Evening Shoots',
        description: 'Available for evening/night shoots',
        available: false,
      ),
      AvailabilityItem(
        icon: Icons.schedule,
        title: 'Short Notice',
        description: 'Available for last-minute bookings',
        available: true,
      ),
    ];

    return ProfileSection(
      title: 'Availability Preferences',
      child: Column(
        children: availabilityTypes.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: item.available
                  ? Colors.green.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: item.available
                    ? Colors.green.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: item.available ? Colors.green : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  item.available ? Icons.check_circle : Icons.cancel,
                  color: item.available ? Colors.green : Colors.grey,
                  size: 16,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AvailabilityItem {
  const AvailabilityItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.available,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool available;
}
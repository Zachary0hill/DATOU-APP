import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/models/models.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_sections.dart';

class AgencySetupScreen extends StatefulWidget {
  const AgencySetupScreen({super.key});

  @override
  State<AgencySetupScreen> createState() => _AgencySetupScreenState();
}

class _AgencySetupScreenState extends State<AgencySetupScreen> {
  final TextEditingController companyController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Agency Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Company Name', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: companyController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                hintText: 'e.g. Acme Agency',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Website', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: websiteController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                hintText: 'https://',
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

class AgencyProfilePage extends ConsumerWidget {
  const AgencyProfilePage({
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
                
                // Agency Specialties
                SkillsSection(
                  skills: profile.skills,
                  title: 'Agency Specialties',
                ),
                
                // Company Stats
                _buildCompanyStatsSection(),
                
                // Services Offered
                _buildServicesSection(),
                
                // Team Members (Featured Talent)
                _buildFeaturedTalentSection(),
                
                // Portfolio/Client Work
                PortfolioSection(portfolioImages: profile.portfolioImages),
                
                // Clients & Partnerships
                _buildClientsSection(),
                
                // Contact Information
                _buildContactInfoSection(),
                
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
                // TODO: Open collaboration/partnership flow
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Partnership inquiry coming soon!')),
                );
              },
            ),
    );
  }

  Widget _buildCompanyStatsSection() {
    return ProfileSection(
      title: 'Company Overview',
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard('Founded', '2018', Icons.business),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Talent', '150+', Icons.group),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Projects', '500+', Icons.work),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.indigo, size: 20),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    final services = [
      ServiceItem(
        icon: Icons.search,
        title: 'Talent Representation',
        description: 'Professional representation for models, photographers, and videographers',
      ),
      ServiceItem(
        icon: Icons.campaign,
        title: 'Campaign Management',
        description: 'End-to-end campaign planning and execution',
      ),
      ServiceItem(
        icon: Icons.event,
        title: 'Event Production',
        description: 'Fashion shows, photo shoots, and promotional events',
      ),
      ServiceItem(
        icon: Icons.handshake,
        title: 'Brand Partnerships',
        description: 'Strategic partnerships and collaboration opportunities',
      ),
      ServiceItem(
        icon: Icons.school,
        title: 'Training & Development',
        description: 'Professional development programs for talent',
      ),
      ServiceItem(
        icon: Icons.public,
        title: 'International Placement',
        description: 'Global opportunities and international market access',
      ),
    ];

    return ProfileSection(
      title: 'Services & Capabilities',
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
                    color: Colors.indigo,
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

  Widget _buildFeaturedTalentSection() {
    // This would typically fetch featured talent from the database
    final featuredTalent = [
      TalentItem(name: 'Sarah Johnson', role: 'Model', image: null),
      TalentItem(name: 'Mike Chen', role: 'Photographer', image: null),
      TalentItem(name: 'Emma Davis', role: 'Videographer', image: null),
      TalentItem(name: 'Alex Rivera', role: 'Model', image: null),
    ];

    return ProfileSection(
      title: 'Featured Talent',
      action: TextButton(
        onPressed: () {
          // TODO: Navigate to full talent roster
        },
        child: const Text('View All'),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: featuredTalent.length,
        itemBuilder: (context, index) {
          final talent = featuredTalent[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.person, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        talent.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        talent.role,
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
        },
      ),
    );
  }

  Widget _buildClientsSection() {
    final clients = [
      'Fashion Nova',
      'Nike',
      'Zara',
      'H&M',
      'Adidas',
      'Calvin Klein',
      'Tommy Hilfiger',
      'Guess',
    ];

    return ProfileSection(
      title: 'Notable Clients',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: clients.map((client) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  client,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return ProfileSection(
      title: 'Contact Information',
      child: Column(
        children: [
          _buildContactRow(Icons.email, 'Email', 'info@agency.com'),
          _buildContactRow(Icons.phone, 'Phone', '+1 (555) 123-4567'),
          _buildContactRow(Icons.location_on, 'Address', 'New York, NY'),
          _buildContactRow(Icons.schedule, 'Hours', 'Mon-Fri 9AM-6PM'),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
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

class TalentItem {
  const TalentItem({
    required this.name,
    required this.role,
    this.image,
  });

  final String name;
  final String role;
  final String? image;
}
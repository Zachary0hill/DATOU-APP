import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/models.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    required this.title,
    required this.child,
    this.action,
    super.key,
  });

  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({
    required this.profile,
    super.key,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: 'About',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (profile.bio != null) ...[
            Text(
              profile.bio!,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 16),
          ],
          _buildInfoRow(Icons.work, 'Experience', '${profile.yearsExperience ?? 0} years'),
          if (profile.website != null)
            _buildInfoRow(Icons.link, 'Website', profile.website!),
          if (profile.instagramHandle != null)
            _buildInfoRow(Icons.camera_alt, 'Instagram', '@${profile.instagramHandle}'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
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

class RatesSection extends StatelessWidget {
  const RatesSection({
    required this.profile,
    super.key,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    if (profile.hourlyRate == null && profile.dayRate == null) {
      return const SizedBox.shrink();
    }

    return ProfileSection(
      title: 'Rates',
      child: Row(
        children: [
          if (profile.hourlyRate != null) ...[
            Expanded(
              child: _buildRateCard(
                'Hourly Rate',
                '\$${profile.hourlyRate!.toStringAsFixed(0)}/hr',
                Icons.access_time,
              ),
            ),
            if (profile.dayRate != null) const SizedBox(width: 16),
          ],
          if (profile.dayRate != null) ...[
            Expanded(
              child: _buildRateCard(
                'Day Rate',
                '\$${profile.dayRate!.toStringAsFixed(0)}/day',
                Icons.calendar_today,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRateCard(String title, String rate, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kPrimary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: kPrimary),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            rate,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({
    required this.skills,
    required this.title,
    super.key,
  });

  final List<String>? skills;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (skills == null || skills!.isEmpty) {
      return const SizedBox.shrink();
    }

    return ProfileSection(
      title: title,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: skills!.map((skill) {
          return Chip(
            label: Text(
              skill,
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: kPrimary.withOpacity(0.1),
            side: BorderSide(color: kPrimary.withOpacity(0.3)),
          );
        }).toList(),
      ),
    );
  }
}

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({
    required this.portfolioImages,
    super.key,
  });

  final List<String>? portfolioImages;

  @override
  Widget build(BuildContext context) {
    if (portfolioImages == null || portfolioImages!.isEmpty) {
      return ProfileSection(
        title: 'Portfolio',
        child: Container(
          padding: const EdgeInsets.all(32),
          child: const Center(
            child: Text(
              'No portfolio images yet',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return ProfileSection(
      title: 'Portfolio',
      action: TextButton(
        onPressed: () {
          // TODO: Navigate to full portfolio view
        },
        child: const Text('View All'),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: portfolioImages!.length > 6 ? 6 : portfolioImages!.length,
        itemBuilder: (context, index) {
          if (index == 5 && portfolioImages!.length > 6) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: portfolioImages![index],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '+${portfolioImages!.length - 5}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: portfolioImages![index],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({
    required this.onMessagePressed,
    required this.onBookPressed,
    super.key,
  });

  final VoidCallback onMessagePressed;
  final VoidCallback onBookPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onMessagePressed,
              icon: const Icon(Icons.message),
              label: const Text('Message'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onBookPressed,
              icon: const Icon(Icons.calendar_today),
              label: const Text('Book Now'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
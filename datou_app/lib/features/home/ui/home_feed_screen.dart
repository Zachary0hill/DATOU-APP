import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/ui/glass_container.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/logic/auth_providers.dart';
import '../../calendar/logic/calendar_providers.dart';
import 'social_feed_screen.dart';

class HomeFeedScreen extends ConsumerWidget {
  const HomeFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Return the new social media style feed
    return const SocialFeedScreen();
  }
  
  Widget _buildOriginalHomeFeed(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(userRoleProvider);
    final currentUser = ref.watch(currentUserProvider);

    final isGuest = ref.watch(guestModeProvider);
    
    return Scaffold(
      appBar: GlassAppBar(
        title: 'DATOU',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon!')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
          SliverToBoxAdapter(
            child: _buildHeroSection(context, ref, isGuest, currentUser, userRole),
          ),
          
          const SliverPadding(padding: EdgeInsets.only(top: 32)),
          
          // Quick Stats or Upcoming Events
          if (!isGuest) ...[
            SliverToBoxAdapter(
              child: _buildQuickStatsSection(context, ref),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 32)),
          ],
          
          // Quick Actions Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          
          // Quick Actions Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: _buildQuickActionsSliverGrid(context, ref, isGuest),
          ),
          
          const SliverPadding(padding: EdgeInsets.only(top: 32)),
          
          // Feature Categories Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Categories',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          
          // Feature Categories Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: _buildFeaturesSliverGrid(context),
          ),
          
          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
        ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, WidgetRef ref, bool isGuest, dynamic currentUser, dynamic userRole) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kPrimary.withOpacity(0.1),
            kPrimary.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
        child: Column(
          children: [
            // Profile Avatar or Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kPrimary,
                    kPrimary.withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: kPrimary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Welcome Text
            Text(
              isGuest ? 'Welcome to DATOU' : 'Welcome back${currentUser?.userMetadata?['name'] != null ? ', ${currentUser!.userMetadata!['name']}' : ''}!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 12),
            
            Text(
              isGuest 
                ? 'Connect with photographers, videographers, models, and agencies'
                : 'Your creative marketplace awaits',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark 
                  ? kText.withOpacity(0.7) 
                  : kTextLight.withOpacity(0.7),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            
            if (userRole != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: kPrimary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getRoleIcon(userRole),
                      size: 18,
                      color: kPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatRole(userRole.name),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 32),
            
            // Main CTA Button
            if (isGuest) ...[
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign up to start browsing listings!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Explore Marketplace',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign up to access all features!'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kPrimary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Join DATOU',
                    style: TextStyle(
                      fontSize: 16,
                      color: kPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsSection(BuildContext context, WidgetRef ref) {
    final upcomingEvents = ref.watch(upcomingEventsProvider);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Dashboard',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Today\'s Events',
                  upcomingEvents.when(
                    data: (events) {
                      final today = DateTime.now();
                      final todayEvents = events.where((event) {
                        final eventDate = DateTime(
                          event.startDate.year,
                          event.startDate.month,
                          event.startDate.day,
                        );
                        final todayDate = DateTime(today.year, today.month, today.day);
                        return eventDate == todayDate;
                      }).length;
                      return todayEvents.toString();
                    },
                    loading: () => '...',
                    error: (_, __) => '0',
                  ),
                  Icons.today,
                  kPrimary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Upcoming',
                  upcomingEvents.when(
                    data: (events) => events.length.toString(),
                    loading: () => '...',
                    error: (_, __) => '0',
                  ),
                  Icons.schedule,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Active Projects',
                  '0',
                  Icons.work,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Messages',
                  '0',
                  Icons.message,
                  Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).brightness == Brightness.dark 
                ? kText.withOpacity(0.7) 
                : kTextLight.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSliverGrid(BuildContext context, WidgetRef ref, bool isGuest) {
    final actions = isGuest 
      ? [
          {
            'title': 'Browse Listings',
            'subtitle': 'Discover available gigs',
            'icon': Icons.search,
            'color': kPrimary,
            'onTap': () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign up to browse listings!')),
              );
            },
          },
          {
            'title': 'Join Community',
            'subtitle': 'Connect with creatives',
            'icon': Icons.group,
            'color': Colors.orange,
            'onTap': () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign up to join the community!')),
              );
            },
          },
        ]
      : [
          {
            'title': 'Create Listing',
            'subtitle': 'Post a new gig',
            'icon': Icons.add_circle,
            'color': kPrimary,
            'onTap': () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Create listing coming soon!')),
              );
            },
          },
          {
            'title': 'My Calendar',
            'subtitle': 'View upcoming events',
            'icon': Icons.calendar_today,
            'color': Colors.blue,
            'onTap': () {
              // Navigate to calendar tab
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Check your calendar tab below!')),
              );
            },
          },
          {
            'title': 'Messages',
            'subtitle': 'Chat with clients',
            'icon': Icons.message,
            'color': Colors.green,
            'onTap': () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Messaging coming soon!')),
              );
            },
          },
          {
            'title': 'My Profile',
            'subtitle': 'Edit your portfolio',
            'icon': Icons.person,
            'color': Colors.orange,
            'onTap': () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Check your profile tab below!')),
              );
            },
          },
        ];

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
        final action = actions[index];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action['onTap'] as VoidCallback,
            borderRadius: BorderRadius.circular(24),
            child: GlassContainer(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  action['icon'] as IconData,
                  size: 32,
                  color: action['color'] as Color,
                ),
                const SizedBox(height: 12),
                Text(
                  action['title'] as String,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  action['subtitle'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark 
                      ? kText.withOpacity(0.6) 
                      : kTextLight.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            ),
          ),
        );
        },
        childCount: actions.length,
      ),
    );
  }

  IconData _getRoleIcon(dynamic userRole) {
    switch (userRole.toString()) {
      case 'UserRole.photographer':
        return Icons.camera_alt;
      case 'UserRole.videographer':
        return Icons.videocam;
      case 'UserRole.model':
        return Icons.person;
      case 'UserRole.agency':
        return Icons.business;
      default:
        return Icons.person;
    }
  }

  String _formatRole(String role) {
    switch (role) {
      case 'photographer':
        return 'Photographer';
      case 'videographer':
        return 'Videographer';
      case 'model':
        return 'Model';
      case 'agency':
        return 'Agency';
      default:
        return role.toUpperCase();
    }
  }
  
  Widget _buildFeaturesSliverGrid(BuildContext context) {
    final features = [
      {
        'icon': Icons.camera_alt,
        'title': 'Photography',
        'description': 'Professional photo shoots',
        'color': Colors.blue,
      },
      {
        'icon': Icons.videocam,
        'title': 'Videography', 
        'description': 'Cinematic video content',
        'color': Colors.purple,
      },
      {
        'icon': Icons.person,
        'title': 'Modeling',
        'description': 'Talented models',
        'color': Colors.pink,
      },
      {
        'icon': Icons.business,
        'title': 'Agencies',
        'description': 'Creative agencies',
        'color': Colors.orange,
      },
    ];
    
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
        final feature = features[index];
        final color = feature['color'] as Color;
        
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${feature['title']} section coming soon!'),
                ),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: GlassContainer(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    size: 32,
                    color: color,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  feature['title'] as String,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  feature['description'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark 
                      ? kText.withOpacity(0.6) 
                      : kTextLight.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            ),
          ),
        );
        },
        childCount: features.length,
      ),
    );
  }
}
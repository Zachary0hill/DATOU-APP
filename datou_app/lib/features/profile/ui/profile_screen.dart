import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../auth/logic/auth_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final userRole = ref.watch(userRoleProvider);
    final isGuest = ref.watch(guestModeProvider);
    final hasSkippedRoleSelection = ref.watch(hasSkippedRoleSelectionProvider);

    Future<void> handleSignOut() async {
      try {
        if (isGuest) {
          // Clear guest mode
          ref.read(guestModeProvider.notifier).state = false;
        } else {
          // Sign out authenticated user
          final authRepository = ref.read(authRepositoryProvider);
          await authRepository.signOut();
        }
        
        if (context.mounted) {
          context.go('/auth/signup');
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with title and settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                        icon: Icon(
                          ref.watch(themeProvider) == ThemeMode.dark 
                            ? Icons.light_mode 
                            : Icons.dark_mode,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.push('/profile/settings'),
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

                        // Compact Profile Header
            _buildProfileHeader(isGuest, currentUser, userRole),
            
            // Portfolio/Content Area - Takes up most of the screen
            Expanded(
              child: !isGuest ? _buildTabSection() : _buildGuestPrompt(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isGuest, dynamic currentUser, dynamic userRole) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Profile Picture - smaller and on the left
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF8B5CF6),
                  Color(0xFFF59E0B),
                  Color(0xFFEF4444),
                  Color(0xFF8B5CF6),
                ],
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[800],
                ),
                child: ClipOval(
                  child: currentUser?.userMetadata?['avatar_url'] != null
                      ? Image.network(
                          currentUser!.userMetadata!['avatar_url'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(),
                        )
                      : _buildDefaultAvatar(),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  isGuest 
                      ? 'Guest User'
                      : currentUser?.userMetadata?['name'] ?? 'David Jerome',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                
                // User Role
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isGuest 
                        ? 'Guest'
                        : _getRoleDisplayName(userRole),
                    style: const TextStyle(
                      color: Color(0xFF8B5CF6),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Stats Row
                Row(
                  children: [
                    // Followers
                    Row(
                      children: [
                        Text(
                          isGuest ? '0' : '24k',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Followers',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    // Following
                    Row(
                      children: [
                        Text(
                          isGuest ? '0' : '152',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Following',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Edit Profile Button (for non-guests)
          if (!isGuest) ...[
            GestureDetector(
              onTap: () => context.push('/profile/edit'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ] else ...[
            // Sign up button for guests
            GestureDetector(
              onTap: () => context.go('/auth/signup'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[700],
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        size: 32,
        color: Colors.white54,
      ),
    );
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Tab Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(22),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'Portfolio'),
              Tab(text: 'Packages'),
              Tab(text: 'Contact'),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Tab Content - Expands to fill remaining space
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPortfolioTab(),
                _buildPackagesTab(),
                _buildContactTab(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioTab() {
    // Mock portfolio items - replace with actual data
    final portfolioItems = List.generate(12, (index) => index);
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: portfolioItems.isEmpty 
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  size: 48,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text(
                  'No portfolio items yet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Add your best work to showcase',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 1,
            ),
            itemCount: portfolioItems.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Placeholder for portfolio image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: Colors.grey[300],
                        child: Icon(
                          index % 3 == 0 
                            ? Icons.photo_camera
                            : index % 3 == 1 
                              ? Icons.videocam
                              : Icons.image,
                          color: Colors.grey[600],
                          size: 32,
                        ),
                      ),
                    ),
                    // Overlay for interaction
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          // Handle portfolio item tap
                        },
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  Widget _buildPackagesTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Packages Coming Soon',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Offer service packages to clients',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.contact_mail,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Contact Info Coming Soon',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Share your contact details',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _getRoleDisplayName(UserRole? role) {
    switch (role) {
      case UserRole.model:
        return 'Model';
      case UserRole.photographer:
        return 'Photographer';
      case UserRole.videographer:
        return 'Videographer';
      case UserRole.agency:
        return 'Agency';
      default:
        return 'Creative';
    }
  }

  Widget _buildGuestPrompt() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            size: 64,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          const Text(
            'Sign up to create your portfolio',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Join our creative community to showcase your work, connect with clients, and grow your business.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (context.mounted) {
                    context.go('/auth/signup');
                  }
                },
                borderRadius: BorderRadius.circular(24),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/ui/glass_container.dart';
import '../../../core/theme/theme_provider.dart';
import '../../auth/logic/auth_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      appBar: GlassAppBar(
        title: 'Profile',
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(
              ref.watch(themeProvider) == ThemeMode.dark 
                ? Icons.light_mode 
                : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isGuest 
                ? 'Guest User'
                : currentUser?.userMetadata?['name'] ?? 'User',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (currentUser?.email != null && !isGuest)
              Text(
                currentUser!.email!,
                style: const TextStyle(color: Colors.grey),
              ),
            if (isGuest)
              const Text(
                'Browse the marketplace without an account',
                style: TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 8),
            if (userRole != null)
              Chip(
                label: Text(userRole.name.toUpperCase()),
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
            const SizedBox(height: 32),
            
            // Show role selection prompt for users who skipped it
            if (!isGuest && userRole == null && hasSkippedRoleSelection)
              Card(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: ListTile(
                  leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
                  title: const Text('Complete Your Profile'),
                  subtitle: const Text('Select your role to access all features'),
                  trailing: TextButton(
                    onPressed: () => context.go('/role-selection'),
                    child: const Text('Select Role'),
                  ),
                ),
              ),
            if (!isGuest && userRole == null && hasSkippedRoleSelection)
              const SizedBox(height: 16),
              
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit profile coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Portfolio'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Portfolio coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Reviews'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reviews coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Payment Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment settings coming soon!')),
                );
              },
            ),
            const Divider(),
            if (isGuest)
              ListTile(
                leading: const Icon(Icons.login, color: Colors.blue),
                title: const Text('Sign Up / Log In', style: TextStyle(color: Colors.blue)),
                subtitle: const Text('Create an account to access all features'),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Create Account'),
                    content: const Text('Sign up to create listings, book jobs, and access all features.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Maybe Later'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.go('/auth/signup');
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
            if (!isGuest && currentUser != null)
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Sign Out'),
                    content: const Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          handleSignOut();
                        },
                        child: const Text('Sign Out'),
                      ),
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
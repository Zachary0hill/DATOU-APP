import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/ui/glass_container.dart';
import '../../auth/logic/auth_providers.dart';
import '../../listings/ui/create_listing_flow.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final userRole = ref.watch(userRoleProvider);
    final isGuest = ref.watch(guestModeProvider);

    void onDestinationSelected(int index) {
      ref.read(currentIndexProvider.notifier).state = index;
      
      switch (index) {
        case 0:
          context.go('/home');
          break;
        case 1:
          context.go('/listings');
          break;
        case 2:
          _showCreateListingModal(context, ref);
          break;
        case 3:
          context.go('/calendar');
          break;
        case 4:
          context.go('/profile');
          break;
      }
    }
    
    // Adjust navigation items based on user role
    final navigationItems = _getNavigationItems(userRole);

    return Scaffold(
      body: child,
      bottomNavigationBar: GlassBottomNav(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: navigationItems,
      ),
    );
  }

  List<NavigationDestination> _getNavigationItems(UserRole? userRole) {
    return [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.list_outlined),
        selectedIcon: Icon(Icons.list),
        label: 'Listings',
      ),
      const NavigationDestination(
        icon: Icon(Icons.add_circle_outline),
        selectedIcon: Icon(Icons.add_circle),
        label: 'Create',
      ),
      NavigationDestination(
        icon: const Icon(Icons.calendar_today_outlined),
        selectedIcon: const Icon(Icons.calendar_today),
        label: userRole == UserRole.agency ? 'My Jobs' : 'Calendar',
      ),
      const NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];
  }

  void _showCreateListingModal(BuildContext context, WidgetRef ref) {
    final isGuest = ref.read(guestModeProvider);
    
    if (isGuest) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Account Required'),
          content: const Text(
            'You need to create an account to post listings. Sign up to access all features!',
          ),
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
      );
      return;
    }
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateListingFlow(),
    );
  }
}
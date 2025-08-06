import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../constants.dart';
import '../../features/auth/logic/auth_providers.dart';
import '../../features/auth/ui/sign_up_screen.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/guest_continue_screen.dart';
import '../../features/onboarding/ui/role_selection_screen.dart';
import '../../features/main/ui/main_scaffold.dart';
import '../../features/home/ui/home_feed_screen.dart';
import '../../features/listings/ui/listings_screen.dart';
import '../../features/listings/ui/create_listing_screen.dart';
import '../../features/calendar/ui/calendar_screen.dart';
import '../../features/calendar/ui/my_jobs_screen.dart';
import '../../features/profile/ui/profile_screen.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final userRole = ref.watch(userRoleProvider);
  final isGuest = ref.watch(guestModeProvider);
  final hasSkippedRoleSelection = ref.watch(hasSkippedRoleSelectionProvider);
  
  return GoRouter(
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.when(
        data: (authState) => authState.session != null,
        loading: () => false,
        error: (_, __) => false,
      );
      
      final hasAccess = isLoggedIn || isGuest;
      
      // If no access and not on auth screens, redirect to sign up
      if (!hasAccess && !state.uri.path.startsWith('/auth')) {
        return '/auth/signup';
      }
      
      // If logged in but no role selected and hasn't skipped, redirect to role selection
      if (isLoggedIn && !isGuest && userRole == null && !hasSkippedRoleSelection && 
          state.uri.path != '/role-selection') {
        return '/role-selection';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/guest',
        builder: (context, state) => const GuestContinueScreen(),
      ),
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/main',
        redirect: (context, state) => '/home',
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeFeedScreen(),
          ),
          GoRoute(
            path: '/listings',
            builder: (context, state) => const ListingsScreen(),
          ),
          GoRoute(
            path: '/create',
            builder: (context, state) => const CreateListingScreen(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) {
              final role = ref.read(userRoleProvider);
              return role == UserRole.agency
                  ? const MyJobsScreen()
                  : const CalendarScreen();
            },
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
    initialLocation: '/home',
  );
});
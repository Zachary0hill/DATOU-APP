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
import '../../features/profile/ui/edit_profile_screen.dart';
import '../../features/profile/ui/photographer_profile_page.dart';
import '../../features/profile/ui/videographer_profile_page.dart';
import '../../features/profile/ui/model_profile_page.dart';
import '../../features/profile/ui/agency_profile_page.dart';
import '../../features/profile/ui/settings_screen.dart';
import '../../features/onboarding/ui/terms_screen.dart';
import '../../features/content/ui/create_post_screen.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final userRole = ref.watch(userRoleProvider);
  final isGuest = ref.watch(guestModeProvider);
  final hasSkippedRoleSelection = ref.watch(hasSkippedRoleSelectionProvider);
  
  return GoRouter(
    debugLogDiagnostics: true,
    // Global transition: subtle fade for seamless feel
    routes: [
      GoRoute(
        path: '/auth/signup',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignUpScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/auth/login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/auth/guest',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const GuestContinueScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/role-selection',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const RoleSelectionScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/setup/photographer',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PhotographerSetupScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/setup/videographer',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const VideographerSetupScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/setup/model',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ModelSetupScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/setup/agency',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AgencySetupScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/terms',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const TermsAcceptanceScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/create-post',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CreatePostScreen(),
          transitionsBuilder: _fadeTransition,
        ),
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
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomeFeedScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/listings',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ListingsScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/create',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const CreateListingScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/calendar',
            pageBuilder: (context, state) {
              final role = ref.read(userRoleProvider);
              final child = role == UserRole.agency
                  ? const MyJobsScreen()
                  : const CalendarScreen();
              return CustomTransitionPage(
                key: state.pageKey,
                child: child,
                transitionsBuilder: _fadeTransition,
              );
            },
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ProfileScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/profile/settings',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SettingsScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/profile/edit',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const EditProfileScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
        ],
      ),
    ],
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
          state.uri.path != '/role-selection' &&
          !state.uri.path.startsWith('/setup') &&
          state.uri.path != '/terms') {
        return '/role-selection';
      }
      
      return null;
    },
    initialLocation: '/home',
  );
});

// Simple fade transition used across routes for a seamless feel
Widget _fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondary, Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: child,
  );
}
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants.dart';
import '../data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StreamProvider<AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (state) => state.session?.user,
    loading: () => null,
    error: (_, __) => null,
  );
});

final userRoleProvider = Provider<UserRole?>((ref) {
  // Recompute the user's role whenever the authentication state changes
  // so routing decisions always reflect the latest session metadata.
  final _ = ref.watch(authStateProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getUserRole();
});

final selectedRoleProvider = StateProvider<UserRole?>((ref) => null);

final authLoadingProvider = StateProvider<bool>((ref) => false);

final guestModeProvider = StateProvider<bool>((ref) => false);

final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  final isGuest = ref.watch(guestModeProvider);
  return user != null || isGuest;
});

final hasSkippedRoleSelectionProvider = StateProvider<bool>((ref) => false);
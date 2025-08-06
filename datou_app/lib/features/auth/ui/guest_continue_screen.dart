import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/ui/glass_container.dart';
import '../logic/auth_providers.dart';

class GuestContinueScreen extends ConsumerWidget {
  const GuestContinueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authLoadingProvider);

    Future<void> handleGuestContinue() async {
      ref.read(authLoadingProvider.notifier).state = true;
      
      try {
        // Set guest mode flag instead of signing in anonymously
        ref.read(guestModeProvider.notifier).state = true;
        
        if (context.mounted) {
          context.go('/home');
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        ref.read(authLoadingProvider.notifier).state = false;
      }
    }

    return Scaffold(
      appBar: const GlassAppBar(
        title: 'Continue as Guest',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_outline,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 32),
            const Text(
              'Explore DATOU',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Continue as a guest to browse the marketplace. '
              'You can create an account later to access all features.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : handleGuestContinue,
                child: isLoading 
                  ? const CircularProgressIndicator()
                  : const Text('Continue as Guest'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => context.go('/auth/signup'),
                  child: const Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () => context.go('/auth/login'),
                  child: const Text('Log In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
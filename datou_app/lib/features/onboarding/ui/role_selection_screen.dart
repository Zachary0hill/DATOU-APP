import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants.dart';
import '../../../core/ui/glass_container.dart';
import '../../auth/logic/auth_providers.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = ref.watch(selectedRoleProvider);
    final isLoading = ref.watch(authLoadingProvider);

    Future<void> handleRoleSelection() async {
      if (selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a role')),
        );
        return;
      }

      ref.read(authLoadingProvider.notifier).state = true;
      
      try {
        final authRepository = ref.read(authRepositoryProvider);
        await authRepository.updateUserRole(selectedRole);
        
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
      appBar: GlassAppBar(
        title: 'Choose Your Role',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/auth/signup'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark that user has skipped role selection
              ref.read(hasSkippedRoleSelectionProvider.notifier).state = true;
              context.go('/home');
            },
            child: const Text('Skip for now'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'What describes you best?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _RoleCard(
                    role: UserRole.photographer,
                    title: 'Photographer',
                    icon: Icons.camera_alt,
                    description: 'Capture stunning images',
                    isSelected: selectedRole == UserRole.photographer,
                    onTap: () => ref.read(selectedRoleProvider.notifier).state = 
                        UserRole.photographer,
                  ),
                  _RoleCard(
                    role: UserRole.videographer,
                    title: 'Videographer',
                    icon: Icons.videocam,
                    description: 'Create amazing videos',
                    isSelected: selectedRole == UserRole.videographer,
                    onTap: () => ref.read(selectedRoleProvider.notifier).state = 
                        UserRole.videographer,
                  ),
                  _RoleCard(
                    role: UserRole.model,
                    title: 'Model',
                    icon: Icons.person,
                    description: 'Showcase your talent',
                    isSelected: selectedRole == UserRole.model,
                    onTap: () => ref.read(selectedRoleProvider.notifier).state = 
                        UserRole.model,
                  ),
                  _RoleCard(
                    role: UserRole.agency,
                    title: 'Agency',
                    icon: Icons.business,
                    description: 'Connect talent & clients',
                    isSelected: selectedRole == UserRole.agency,
                    onTap: () => ref.read(selectedRoleProvider.notifier).state = 
                        UserRole.agency,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedRole != null && !isLoading 
                    ? handleRoleSelection 
                    : null,
                child: isLoading 
                  ? const CircularProgressIndicator()
                  : const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.title,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final UserRole role;
  final String title;
  final IconData icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isSelected 
                ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: isSelected 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected 
                      ? Theme.of(context).primaryColor 
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
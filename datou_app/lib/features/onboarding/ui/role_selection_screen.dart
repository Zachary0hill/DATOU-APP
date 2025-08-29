import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/logic/auth_providers.dart';

// Shared gradient button used on this screen
Widget _buildGradientButton({
  required String text,
  required VoidCallback? onPressed,
  required Gradient gradient,
}) {
  return Container(
    width: double.infinity,
    height: 56,
    decoration: BoxDecoration(
      gradient: onPressed != null ? gradient : null,
      color: onPressed == null ? Colors.grey[600] : null,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(25),
        child: const Center(
          child: Text(
            'Continue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}

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
          switch (selectedRole) {
            case UserRole.photographer:
              context.go('/setup/photographer');
              break;
            case UserRole.videographer:
              context.go('/setup/videographer');
              break;
            case UserRole.model:
              context.go('/setup/model');
              break;
            case UserRole.agency:
              context.go('/setup/agency');
              break;
          }
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // Header with back button and skip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.go('/auth/signup'),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Mark that user has skipped role selection
                          ref.read(hasSkippedRoleSelectionProvider.notifier).state = true;
                          context.go('/home');
                        },
                        child: const Text(
                          'Skip for now',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  const Text(
                    'Choose Your Role',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  const Text(
                    'What describes you best?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Role cards grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
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
                  
                  const SizedBox(height: 32),
                  
                  // Continue button
                  _buildGradientButton(
                    text: isLoading ? 'Loading...' : 'Continue',
                    onPressed: selectedRole != null && !isLoading 
                        ? handleRoleSelection 
                        : null,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
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
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: isSelected 
            ? Border.all(
                width: 2,
                color: Colors.transparent,
              )
            : null,
        gradient: isSelected 
            ? const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              )
            : null,
      ),
      child: Container(
        margin: isSelected ? const EdgeInsets.all(2) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? const Color(0xFF6366F1).withOpacity(0.2)
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: isSelected 
                          ? const Color(0xFF6366F1)
                          : Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected 
                          ? Colors.white
                          : Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected 
                          ? Colors.white70
                          : Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback? onPressed,
    required Gradient gradient,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: onPressed != null ? gradient : null,
        color: onPressed == null ? Colors.grey[600] : null,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
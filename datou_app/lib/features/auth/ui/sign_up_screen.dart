import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../logic/auth_providers.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final isLoading = ref.watch(authLoadingProvider);
    final isPasswordVisible = useState(false);
    final isConfirmPasswordVisible = useState(false);

    Future<void> handleSignUp() async {
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      ref.read(authLoadingProvider.notifier).state = true;
      
      try {
        final authRepository = ref.read(authRepositoryProvider);
        await authRepository.signUpWithEmailAndPassword(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
        
        if (context.mounted) {
          context.go('/role-selection');
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
              const SizedBox(height: 28),
              // Tab Headers
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go('/auth/login'),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Underline for Sign Up
              Row(
                children: [
                  Container(width: 80, height: 1), // Space for Log In
                  const SizedBox(width: 40),
                  Container(
                    width: 100,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              
              const Text(
                "Let's get started by filling out the form below.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),
              
                  Column(
                    children: [
                      // Name Field
                      _buildTextField(
                        controller: nameController,
                        hintText: 'Full Name',
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 12),
                      
                      // Email Field
                      _buildTextField(
                        controller: emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      
                      // Password Field
                      _buildTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: !isPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () => isPasswordVisible.value = !isPasswordVisible.value,
                          icon: Icon(
                            isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Confirm Password Field
                      _buildTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: !isConfirmPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value,
                          icon: Icon(
                            isConfirmPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Create Account Button
                      _buildGradientButton(
                        text: isLoading ? 'Creating Account...' : 'Create Account',
                        onPressed: isLoading ? null : handleSignUp,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      const Text(
                        'Or sign up with',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Google Sign Up
                      _buildSocialButton(
                        text: 'Continue with Google',
                        icon: Icons.g_mobiledata,
                        onPressed: () {
                          // TODO: Implement Google sign up
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Google sign up coming soon!')),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      
                      // Apple Sign Up
                      _buildSocialButton(
                        text: 'Continue with Apple',
                        icon: Icons.apple,
                        onPressed: () {
                          // TODO: Implement Apple sign up
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Apple sign up coming soon!')),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
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

  Widget _buildSocialButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
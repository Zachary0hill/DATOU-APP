import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/theme/theme_provider.dart';
import '../../auth/logic/auth_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _handleSignOut(BuildContext context, WidgetRef ref) async {
    try {
      final isGuest = ref.read(guestModeProvider);
      if (isGuest) {
        ref.read(guestModeProvider.notifier).state = false;
      } else {
        await ref.read(authRepositoryProvider).signOut();
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          _SectionHeader(title: 'Account'),
          _ItemTile(
            icon: Icons.person_outline,
            title: 'Edit profile',
            onTap: () => context.push('/profile/edit'),
          ),
          _ItemTile(
            icon: Icons.logout,
            title: 'Sign out',
            destructive: true,
            onTap: () => _handleSignOut(context, ref),
          ),
          const SizedBox(height: 16),
          _SectionHeader(title: 'Appearance'),
          SwitchListTile.adaptive(
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.white24,
            title: const Text('Dark mode', style: TextStyle(color: Colors.white)),
            value: isDark,
            onChanged: (_) => ref.read(themeProvider.notifier).toggleTheme(),
          ),
          const SizedBox(height: 16),
          _SectionHeader(title: 'About'),
          const _StaticTile(
            icon: Icons.info_outline,
            title: 'Version',
            value: '1.0.0',
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.icon,
    required this.title,
    this.onTap,
    this.destructive = false,
  });
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? const Color(0xFFFF6B6B) : Colors.white;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: Icon(Icons.chevron_right, color: color.withOpacity(0.7)),
      onTap: onTap,
    );
  }
}

class _StaticTile extends StatelessWidget {
  const _StaticTile({required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Text(value, style: const TextStyle(color: Colors.white70)),
    );
  }
}



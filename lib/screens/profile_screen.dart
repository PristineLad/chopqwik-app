import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
    children: [
      const Text('Profile', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('Your account and preferences.', style: TextStyle(color: AppTheme.muted, height: 1.4)),
      const SizedBox(height: 24),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
        CircleAvatar(radius: 28, backgroundColor: AppTheme.accent.withValues(alpha: 0.5), child: const Icon(Icons.person_rounded, color: AppTheme.primaryDark, size: 30)),
        const SizedBox(width: 14),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Guest preview', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          SizedBox(height: 4),
          Text('Sign-in will be connected in the next phase.', style: TextStyle(color: AppTheme.muted)),
        ])),
      ]))),
      const SizedBox(height: 16),
      _ProfileItem(icon: Icons.receipt_long_outlined, title: 'Transaction history', subtitle: 'Your bill payment records', onTap: () => _notice(context)),
      _ProfileItem(icon: Icons.verified_user_outlined, title: 'Account verification', subtitle: 'Verification status and details', onTap: () => _notice(context)),
      _ProfileItem(icon: Icons.help_outline_rounded, title: 'Help and support', subtitle: 'Get help with an issue', onTap: () => _notice(context)),
      _ProfileItem(icon: Icons.privacy_tip_outlined, title: 'Privacy and security', subtitle: 'Account protection information', onTap: () => _notice(context)),
    ],
  );

  static void _notice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This feature will be connected after the account flow is reviewed.')));
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    onTap: onTap, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    leading: Icon(icon, color: AppTheme.primary, size: 25),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(subtitle),
    trailing: const Icon(Icons.chevron_right_rounded),
  ));
}

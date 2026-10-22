import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
    children: [
      const Text('Profile', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('Your account and help options.', style: TextStyle(color: AppTheme.muted, height: 1.45)),
      const SizedBox(height: 22),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.border)),
        child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(radius: 27, backgroundColor: Color(0xFFFFE3E8), child: Icon(Icons.person_outline_rounded, color: AppTheme.primaryDark, size: 30)),
          SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Guest preview', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            SizedBox(height: 5),
            Text('You are not signed in. Account registration and login are not connected in this preview.', style: TextStyle(color: AppTheme.muted, height: 1.45)),
          ])),
        ]),
      ),
      const SizedBox(height: 16),
      const Text('Account options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      _ProfileItem(icon: Icons.receipt_long_outlined, title: 'Transaction history', subtitle: 'Available after secure account setup'),
      _ProfileItem(icon: Icons.verified_user_outlined, title: 'Account verification', subtitle: 'Not available in this preview'),
      _ProfileItem(icon: Icons.privacy_tip_outlined, title: 'Privacy and security', subtitle: 'Security information will be provided before launch'),
      const SizedBox(height: 18),
      const Text('Need help?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: const Icon(Icons.help_outline_rounded, color: AppTheme.primary, size: 28),
          title: const Text('Help and support', style: TextStyle(fontWeight: FontWeight.w700)),
          subtitle: const Text('This preview cannot yet receive support requests.'),
        ),
      ),
      const SizedBox(height: 18),
      const Text('Preview version · No account actions are available yet.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.muted, fontSize: 12)),
    ],
  );
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      enabled: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Icon(icon, color: AppTheme.muted, size: 25),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.lock_outline_rounded, size: 20),
    ),
  );
}

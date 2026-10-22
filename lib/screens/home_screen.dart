import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
    children: [
      Row(children: [
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('ChopQwik', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
          SizedBox(height: 3),
          Text('Chop life, ChopQwik.', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
        ])),
        IconButton(tooltip: 'Help and notifications', onPressed: () => _notice(context, 'Help and notifications'), icon: const Icon(Icons.help_outline_rounded)),
      ]),
      const SizedBox(height: 22),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primaryDark, AppTheme.primary], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(24)),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('BILLS MADE SIMPLE', style: TextStyle(color: AppTheme.accent, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
          SizedBox(height: 10),
          Text('What would you like to pay for?', style: TextStyle(color: Colors.white, fontSize: 24, height: 1.2, fontWeight: FontWeight.w800)),
          SizedBox(height: 10),
          Text('Choose a service below to get started.', style: TextStyle(color: Colors.white, height: 1.45)),
        ]),
      ),
      const SizedBox(height: 24),
      const Text('Choose a service', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
      const SizedBox(height: 5),
      const Text('Tap one option to continue.', style: TextStyle(color: AppTheme.muted)),
      const SizedBox(height: 14),
      GridView.count(
        crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12,
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.25,
        children: [
          _BillTile(icon: Icons.phone_android_rounded, title: 'Buy airtime', subtitle: 'Top up a phone', onTap: () => _notice(context, 'Airtime')),
          _BillTile(icon: Icons.language_rounded, title: 'Buy data', subtitle: 'Choose a data plan', onTap: () => _notice(context, 'Data')),
          _BillTile(icon: Icons.bolt_rounded, title: 'Electricity', subtitle: 'Pay your meter', onTap: () => _notice(context, 'Electricity')),
          _BillTile(icon: Icons.live_tv_rounded, title: 'Cable TV', subtitle: 'Pay your TV bill', onTap: () => _notice(context, 'Cable TV')),
        ],
      ),
      const SizedBox(height: 22),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFFFF3D9), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFFFE0A3))),
        child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.stars_rounded, color: AppTheme.primaryDark, size: 28), SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('ChopCoins rewards', style: TextStyle(fontWeight: FontWeight.w800)),
            SizedBox(height: 4),
            Text('Rewards are temporarily on hold. You cannot earn or spend ChopCoins yet.', style: TextStyle(color: Color(0xFF4E3B20), height: 1.4)),
          ])),
        ]),
      ),
      const SizedBox(height: 16),
      const Text('Preview only. Bill payments are not available yet.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.muted, fontSize: 12)),
    ],
  );

  static void _notice(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$feature is not available yet. We will enable it after testing.')));
  }
}

class _BillTile extends StatelessWidget {
  const _BillTile({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white, borderRadius: BorderRadius.circular(20),
    child: InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 46, height: 46, decoration: BoxDecoration(color: const Color(0xFFFFE3E8), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppTheme.primary, size: 27)),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppTheme.muted, fontSize: 12)),
        ]),
      ),
    ),
  );
}

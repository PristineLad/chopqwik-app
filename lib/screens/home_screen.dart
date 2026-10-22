import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
    children: [
      Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 28)),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('ChopQwik', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          Text('Bills made simple.', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
        ])),
        IconButton(tooltip: 'Notifications', onPressed: () => _notice(context, 'Notifications'), icon: const Icon(Icons.notifications_none_rounded)),
      ]),
      const SizedBox(height: 26),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primaryDark, AppTheme.primary], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(24)),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('WELCOME TO CHOPQWIK', style: TextStyle(color: AppTheme.accent, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.1)),
          SizedBox(height: 10),
          Text('Your everyday bills,\nall in one place.', style: TextStyle(color: Colors.white, fontSize: 25, height: 1.18, fontWeight: FontWeight.w800)),
          SizedBox(height: 10),
          Text('A simpler way to pay for airtime, data, electricity and TV.', style: TextStyle(color: Colors.white70, height: 1.4)),
        ]),
      ),
      const SizedBox(height: 24),
      const Text('Pay a bill', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
      const SizedBox(height: 12),
      GridView.count(
        crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12,
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.45,
        children: [
          _BillTile(icon: Icons.phone_android_rounded, title: 'Airtime', subtitle: 'Top up a line', onTap: () => _notice(context, 'Airtime')),
          _BillTile(icon: Icons.language_rounded, title: 'Data', subtitle: 'Stay connected', onTap: () => _notice(context, 'Data')),
          _BillTile(icon: Icons.bolt_rounded, title: 'Electricity', subtitle: 'Pay your meter', onTap: () => _notice(context, 'Electricity')),
          _BillTile(icon: Icons.live_tv_rounded, title: 'TV', subtitle: 'Renew a package', onTap: () => _notice(context, 'TV')),
        ],
      ),
      const SizedBox(height: 24),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
        Container(width: 46, height: 46, decoration: BoxDecoration(color: AppTheme.accent.withValues(alpha: 0.45), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.stars_rounded, color: AppTheme.primaryDark)),
        const SizedBox(width: 14),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('ChopCoins', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Your rewards area will appear here.', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
        ])),
        const Icon(Icons.chevron_right_rounded),
      ]))),
      const SizedBox(height: 16),
      const Text('Preview only · Payments and rewards are not active yet.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.muted, fontSize: 12)),
    ],
  );

  static void _notice(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$feature will be enabled after integration testing.')));
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
          Icon(icon, color: AppTheme.primary, size: 27),
          const SizedBox(height: 9),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(color: AppTheme.muted, fontSize: 12)),
        ]),
      ),
    ),
  );
}

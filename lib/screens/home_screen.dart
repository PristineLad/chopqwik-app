import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onSelectService});
  final ValueChanged<String> onSelectService;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
    children: [
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SvgPicture.asset('assets/images/chopqwik_logo.svg', height: 36, fit: BoxFit.contain, alignment: Alignment.centerLeft),
          const SizedBox(height: 6),
          const Text('Chop life, ChopQwik.', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
        ])),
        IconButton(
          tooltip: 'Help and support',
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Help and support'),
              content: const Text('This is a preview version of ChopQwik. Bill payments are not enabled yet. Please do not enter payment details or send money through this preview.'),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
            ),
          ),
          icon: const Icon(Icons.help_outline_rounded),
        ),
      ]),
      const SizedBox(height: 22),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppTheme.primaryDark, AppTheme.primary], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(24),
        ),
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
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.15,
        children: [
          _BillTile(icon: Icons.phone_android_rounded, title: 'Buy airtime', subtitle: 'Top up a phone', onTap: () => onSelectService('Airtime')),
          _BillTile(icon: Icons.language_rounded, title: 'Buy data', subtitle: 'Choose a data plan', onTap: () => onSelectService('Mobile data')),
          _BillTile(icon: Icons.bolt_rounded, title: 'Electricity', subtitle: 'Pay your meter', onTap: () => onSelectService('Electricity')),
          _BillTile(icon: Icons.live_tv_rounded, title: 'Cable TV', subtitle: 'Pay your TV bill', onTap: () => onSelectService('Cable TV')),
        ],
      ),
      const SizedBox(height: 22),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFFFF3D9), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFFFE0A3))),
        child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.lock_outline_rounded, color: AppTheme.primaryDark, size: 28),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('ChopCoins rewards are on hold', style: TextStyle(fontWeight: FontWeight.w800)),
            SizedBox(height: 4),
            Text('You cannot earn or spend ChopCoins yet. We will update this screen when rewards are approved.', style: TextStyle(color: Color(0xFF4E3B20), height: 1.4)),
          ])),
        ]),
      ),
      const SizedBox(height: 16),
      const Text('Preview only · Payments are not enabled', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.muted, fontSize: 12)),
    ],
  );
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
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 46, height: 46, decoration: BoxDecoration(color: const Color(0xFFFFE3E8), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppTheme.primary, size: 27)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppTheme.muted, fontSize: 12)),
        ]),
      ),
    ),
  );
}

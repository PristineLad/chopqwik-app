import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
    children: [
      const Text('Pay a bill', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('Choose a service to begin. Payments will be enabled after sandbox verification.', style: TextStyle(color: AppTheme.muted, height: 1.4)),
      const SizedBox(height: 24),
      _ServiceRow(icon: Icons.phone_android_rounded, title: 'Airtime', subtitle: 'MTN, Airtel, Glo and 9mobile', onTap: () => _notice(context)),
      _ServiceRow(icon: Icons.language_rounded, title: 'Mobile data', subtitle: 'Browse available data bundles', onTap: () => _notice(context)),
      _ServiceRow(icon: Icons.bolt_rounded, title: 'Electricity', subtitle: 'Supported distribution companies', onTap: () => _notice(context)),
      _ServiceRow(icon: Icons.live_tv_rounded, title: 'Cable TV', subtitle: 'Check and renew a subscription', onTap: () => _notice(context)),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.accent.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(16)),
        child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.info_outline_rounded, color: AppTheme.primaryDark), SizedBox(width: 10),
          Expanded(child: Text('No real payment will be initiated from this preview.', style: TextStyle(color: AppTheme.primaryDark, height: 1.4))),
        ]),
      ),
    ],
  );

  static void _notice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment is disabled until sandbox checks pass.')));
  }
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      onTap: onTap, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: Container(width: 48, height: 48, decoration: BoxDecoration(color: AppTheme.accent.withValues(alpha: 0.35), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppTheme.primaryDark)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Padding(padding: const EdgeInsets.only(top: 4), child: Text(subtitle)),
      trailing: const Icon(Icons.chevron_right_rounded),
    ),
  );
}

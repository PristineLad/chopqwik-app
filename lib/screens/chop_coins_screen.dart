import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChopCoinsScreen extends StatelessWidget {
  const ChopCoinsScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
    children: [
      const Text('ChopCoins', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('Rewards designed to encourage repeat use of ChopQwik.', style: TextStyle(color: AppTheme.muted, height: 1.4)),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(color: AppTheme.primaryDark, borderRadius: BorderRadius.circular(24)),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.stars_rounded, color: AppTheme.accent, size: 34),
          SizedBox(height: 16),
          Text('Available balance', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text('—', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Your verified balance will display here after sign-in.', style: TextStyle(color: Colors.white70, height: 1.4)),
        ]),
      ),
      const SizedBox(height: 20),
      const Card(child: Padding(padding: EdgeInsets.all(18), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.lock_outline_rounded, color: AppTheme.primary), SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Rewards are currently on hold', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 6),
          Text('ChopCoins issuance remains frozen until the board reserve requirements are independently verified. This screen does not issue or spend coins.', style: TextStyle(color: AppTheme.muted, height: 1.45)),
        ])),
      ]))),
      const SizedBox(height: 16),
      const Text('No balance or reward entitlement is being assumed in this preview.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.muted, fontSize: 12)),
    ],
  );
}

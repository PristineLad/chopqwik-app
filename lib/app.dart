import 'package:flutter/material.dart';
import 'screens/chop_coins_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pay_screen.dart';
import 'screens/profile_screen.dart';
import 'theme/app_theme.dart';

class ChopQwikApp extends StatelessWidget {
  const ChopQwikApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ChopQwik',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    home: const AppShell(),
  );
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  String? _requestedService;

  void _openService(String service) {
    setState(() {
      _requestedService = service;
      _selectedIndex = 1;
    });
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
      // Consume a Home-originated service request when leaving Pay. This
      // allows the same service to be selected again on a later visit to Home.
      if (index != 1) _requestedService = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      HomeScreen(onSelectService: _openService),
      PayScreen(initialService: _requestedService),
      const ChopCoinsScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _selectedIndex, children: screens)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long_rounded), label: 'Pay'),
          NavigationDestination(icon: Icon(Icons.stars_outlined), selectedIcon: Icon(Icons.stars_rounded), label: 'ChopCoins'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

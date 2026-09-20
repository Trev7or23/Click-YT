import 'package:click_yt/presentation/screens/screens.dart';

import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  static const name = 'home_screen';

  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedPage = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AppDownloadsPage(),
    const AppSettingsPage(),
  ];

  final List<NavigationDestination> _navigationDestination = [
    const NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      selectedIcon: Icon(Icons.home),
    ),
    const NavigationDestination(
      icon: Icon(Icons.video_collection_outlined),
      label: 'Videos',
      selectedIcon: Icon(Icons.video_collection),
    ),
    const NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      label: 'Settings',
      selectedIcon: Icon(Icons.settings),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedPage,
        onDestinationSelected: (screenIndex) =>
            setState(() => _selectedPage = screenIndex),
        destinations: _navigationDestination,
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
  }
}

import 'package:click_yt/config/themes/app_colors.dart';
import 'package:click_yt/presentation/screens/download/app_home_page.dart';
import 'package:click_yt/presentation/screens/settings/app_settings_page.dart';
import 'package:click_yt/presentation/screens/videos/app_downloads_page.dart';
import 'package:flutter/material.dart';
import 'package:liquid_bottom_nav_bar/liquid_bottom_nav_bar.dart';

class AppMainViewer extends StatefulWidget {
  const new({super.key});

  @override
  State<AppMainViewer> createState() => _MainAppState();
}

class _MainAppState extends State<AppMainViewer> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const AppHomePage(),
    AppDownloadsPage(),
    AppSettingsPage(),
  ];

  final List<LiquidNavItem> _navItems = [
    const LiquidNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    const LiquidNavItem(
      icon: Icons.video_collection_outlined,
      activeIcon: Icons.video_collection,
      label: 'Videos',
    ),
    const LiquidNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LiquidBottomNavBar(
        iconSize: 30,
        style: const LiquidNavStyle(
          containerColor: AppColors.backgroundComponent,
        ),
        activeIconColor: AppColors.foreground,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        onDrag: _onItemTapped,
        items: _navItems,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: _pages,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() {
    _selectedIndex = index;

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  });

  @override
  dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

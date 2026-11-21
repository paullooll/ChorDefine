import 'dart:ui';
import 'package:chordefine/constants/color.dart';
import 'package:chordefine/screens/featuerd_screen.dart';
import 'package:chordefine/screens/progress.dart';
import 'package:chordefine/screens/settingspage.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return const FeaturedScreen();
      case 1:
        return const MyProgress();
      case 2:
        return SettingsPage(
          isDarkMode: _isDarkMode,
          onDarkModeChanged: (bool value) {
            setState(() => _isDarkMode = value);
          },
        );
      default:
        return const FeaturedScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        extendBody: true,
        body: _getSelectedPage(),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kPrimaryColor.withValues(alpha: 0.95),
            selectedItemColor: kSecondaryColor,
            unselectedItemColor: Colors.white54,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.captionText(context),
            ),
            elevation: 0,
            items: [
              _navItem('Featured', 'assets/icons/star.png', 0),
              _navItem('Progress', 'assets/icons/heart.png', 1),
              _navItem('Settings', 'assets/icons/settings.png', 2),
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() => _selectedIndex = index);
            },
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(String label, String iconPath, int index) {
    return BottomNavigationBarItem(
      activeIcon: Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset(iconPath,
            height: 22, color: index == _selectedIndex ? kSecondaryColor : null),
      ),
      icon: Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset(iconPath, height: 22, color: Colors.white38),
      ),
      label: label,
    );
  }
}

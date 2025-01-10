import 'package:block_lesson/market/feature/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'main_screen_body/custom_nav_bar.dart';
import 'main_screen_body/floating_button.dart';

class MainScree extends StatefulWidget {
  const MainScree({super.key});

  @override
  State<MainScree> createState() => _MainScreeState();
}

class _MainScreeState extends State<MainScree> {

  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Products')),
    const Center(child: Text('Favorites')),
    const Center(child: Text('Profile')),
  ];

  int _selectedIndex = 0;

  void _onNavBarItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation or content updates here based on `index`
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screens[_selectedIndex]),
      bottomNavigationBar: CustomBottomNavBar(onItemSelected: _onNavBarItemSelected),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}
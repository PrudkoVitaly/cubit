import 'package:block_lesson/market/feature/cubit/product_cubit.dart';
import 'package:block_lesson/market/feature/screens/favorites_screen.dart';
import 'package:block_lesson/market/feature/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_screen_body/custom_nav_bar.dart';
import 'main_screen_body/floating_button.dart';

class MainScree extends StatefulWidget {
  const MainScree({super.key});

  @override
  State<MainScree> createState() => _MainScreeState();
}

class _MainScreeState extends State<MainScree> {
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(), // Передаем функцию смены языка
      const Center(child: Text('Products')),
      FavoritesScreen(),
      const Center(child: Text('Profile')),
    ];
  }

  int _selectedIndex = 0;

  void _onNavBarItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation or content updates here based on `index`
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        bool hasFavorites = false;
        if (state is ProductSuccess) {
          hasFavorites = state.likedProducts.isNotEmpty;
        }
        return Scaffold(
          body: SafeArea(child: screens[_selectedIndex]),
          bottomNavigationBar: CustomBottomNavBar(
            onItemSelected: _onNavBarItemSelected,
            hasFavorites: hasFavorites,
          ),
          floatingActionButton: FloatingButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}

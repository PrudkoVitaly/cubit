import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int) onItemSelected;
  final bool hasFavorites;

  const CustomBottomNavBar({
    required this.onItemSelected,
    required this.hasFavorites,
    super.key,
  });

  Widget buildNavBarItem({
    required String iconPath,
    required int index,
    required String label,
    bool isHighlighted = false,
  }) {
    return InkWell(
      onTap: () => onItemSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            height: 24,
            width: 24,
            color: isHighlighted ? Colors.red : Colors.grey,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isHighlighted ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      color: Colors.white,
      elevation: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavBarItem(
              iconPath: 'images/ic_home_bottom.png', index: 0, label: 'Home'),
          buildNavBarItem(
              iconPath: 'images/ic_product_bottom.png',
              index: 1,
              label: 'Products'),
          const SizedBox(width: 20), // Space for floating action button
          buildNavBarItem(
            iconPath: 'images/ic_favorite_bottom.png',
            index: 2,
            label: 'Favorites',
            isHighlighted: hasFavorites,
          ),
          buildNavBarItem(
              iconPath: 'images/ic_profile_bottom.png',
              index: 3,
              label: 'Profile'),
        ],
      ),
    );
  }
}

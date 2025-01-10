import 'package:flutter/material.dart';

import '../../../../market_place/constants/app_constans.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                // Handle FAB tap
              },
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppConstants.yellowColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Image(
                    image: AssetImage('images/card_bottom_icon.png'),
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppConstants.redColor,
              child: Text(
                '10', // Example cart count
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
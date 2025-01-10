import 'package:block_lesson/market/feature/screens/home_screen_body/category_body.dart';
import 'package:block_lesson/market/feature/screens/home_screen_body/product_body.dart';
import 'package:flutter/material.dart';

import '../../../market_place/body/previous_order_body.dart';
import '../../../market_place/body/search_body.dart';
import '../../../market_place/constants/app_constans.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBody(),
              _sectionTitle("Categories"),
              const CategoryBody(),
              _sectionTitle("Previous Order"),
              const PreviousOrderBody(),
              _sectionTitle("Popular Deals"),
            ],
          ),
        ),
        ProductBody(),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        text,
        style: AppConstants.textTitle,
      ),
    );
  }
}

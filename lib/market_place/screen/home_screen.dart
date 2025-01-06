import 'package:flutter/material.dart';

import '../body/category_body.dart';
import '../body/previous_order_body.dart';
import '../body/product_body.dart';
import '../body/search_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBody(),
                  _text(text: "Categories"),
                  const CategoryBody(),
                  _text(text: "Previous Order"),
                  PreviousOrderBody(),
                  _text(text: "Products"),
                ],
              ),
            ),
            ProductBody(),
          ],
        ),
      ),
    );
  }

  Widget _text({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
      child: Text(text),
    );
  }
}

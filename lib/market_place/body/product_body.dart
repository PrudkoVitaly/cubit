import 'package:flutter/material.dart';

class ProductBody extends StatelessWidget {
  const ProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 15,
        (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 12, right: 12),
            decoration: const BoxDecoration(color: Colors.blueAccent),
          );
        },
      ),
    );
  }
}

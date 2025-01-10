import 'package:block_lesson/market/feature/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          final categories = state.products.map((e) => e.category).toList();
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryItem(index, categories, context);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCategoryItem(
      int index, List<String> categories, BuildContext context) {
    final category = categories[index];

    return Padding(
      padding: EdgeInsets.only(
        right: 12,
        left: index == 0 ? 12 : 0,
      ),
      child: GestureDetector(
        onTap: () => context.read<ProductCubit>().selectCategory(category),
        child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.orange,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(category.image, height: 50, fit: BoxFit.cover),
              const SizedBox(height: 8),
              Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
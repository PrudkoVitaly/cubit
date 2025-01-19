import 'package:block_lesson/market/feature/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../market_place/constants/app_constans.dart';

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
    final Map<String, Color> categoryColors = {
      'Groceries': AppConstants.greenColor,
      'Appliances': AppConstants.blueColor,
      'Furniture': AppConstants.pinkColor,
      'Electronics': AppConstants.violetColor,
      'Clothing': Colors.purpleAccent,
    };
    final category = categories[index];
    final productCubit = context.read<ProductCubit>();
    final product = productCubit.state is ProductSuccess
        ? (productCubit.state as ProductSuccess)
        .products
        .firstWhere((element) => element.category == category)
        : null;

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
            color: categoryColors[category],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Показываем картинку категории
              if (product != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.categoryImage,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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

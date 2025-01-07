import 'package:block_lesson/market_place/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_constans.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductError) {
          return Center(child: Text(state.error));
        } else if (state is ProductLoaded) {
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.category.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(right: 12, left: index == 0 ? 12 : 0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<ProductCubit>().selectCategory(state.category[index].category);
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CategoryItem.categoryList[index].color,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // spacing: 15,
                        children: [
                          Image.asset(CategoryItem.categoryList[index].image),
                          Text(
                            state.category[index].category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class CategoryItem {
  final String title;
  final String image;
  final Color color;

  CategoryItem({
    required this.title,
    required this.image,
    required this.color,
  });

  static final List<CategoryItem> categoryList = [
    CategoryItem(
      title: 'Groceries',
      image: 'images/groceries_icon.png',
      color: AppConstants.greenColor,
    ),
    CategoryItem(
      title: 'Appliances',
      image: 'images/appliances_icon.png',
      color: AppConstants.blueColor,
    ),
    CategoryItem(
      title: 'Fashion',
      image: 'images/fashion.png',
      color: AppConstants.redColor,
    ),
    CategoryItem(
      title: 'Furniture',
      image: 'images/fashion.png',
      color: AppConstants.violetColor,
    ),
    CategoryItem(
      title: 'Groceries',
      image: 'images/groceries_icon.png',
      color: AppConstants.greenColor,
    ),
    CategoryItem(
      title: 'Appliances',
      image: 'images/appliances_icon.png',
      color: AppConstants.blueColor,
    ),
    CategoryItem(
      title: 'Fashion',
      image: 'images/fashion.png',
      color: AppConstants.redColor,
    ),
    CategoryItem(
      title: 'Furniture',
      image: 'images/fashion.png',
      color: AppConstants.violetColor,
    ),
  ];
}

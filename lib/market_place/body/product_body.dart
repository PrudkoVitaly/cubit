import 'package:block_lesson/market_place/constants/app_constans.dart';
import 'package:block_lesson/market_place/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({super.key});

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ProductError) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("No data"),
            ),
          );
        } else if (state is ProductLoaded) {
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              childAspectRatio: 0.76,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: state.category.length,
              (context, index) {
                final quantity = state.cartQuantities[index] ?? 0;
                return Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border:
                        Border.all(color: const Color(0xFFE8EFF3), width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 198,
                            height: 150,
                            decoration: BoxDecoration(
                              color: state.productsElement[index].like
                                  ? AppConstants.bgLikeColor
                                  : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  ProductItem.products[index].image,
                                  alignment: Alignment.center,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                ),
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ProductCubit>()
                                          .likeProduct(index);
                                    },
                                    child: Icon(
                                      state.productsElement[index].like
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: state.productsElement[index].like
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              state.productsElement[index].title,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "${state.productsElement[index].price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "${state.productsElement[index].rating}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFEA7173),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xFFFFA902),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            quantity == 0
                                ? buttonAddProduct(index)
                                : quantityButtonsAddProduct(index, quantity),

                            // Quantity Product
                            // buttonAddProduct(index),
                            // Add Quantity Product
                            // quantityButtonsAddProduct()
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: Center(
            child: Text("No data"),
          ),
        );
      },
    );
  }

  GestureDetector buttonAddProduct(int index) {
    return GestureDetector(
      onTap: () {
        context.read<ProductCubit>().addToCart(index);
      },
      child: Container(
        width: double.infinity,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppConstants.yellowColor, width: 1),
        ),
        child: const Text(
          "Add to cart",
          style: TextStyle(
            color: AppConstants.yellowColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Row quantityButtonsAddProduct(int index, int quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.read<ProductCubit>().decrementQuantity(index);
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppConstants.redColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          "$quantity",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppConstants.greenColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<ProductCubit>().incrementQuantity(index);
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppConstants.greenColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductItem {
  final String image;
  final String title;
  final String price;
  String quantity = '0';
  final String? offer;
  final String rating;
  bool isLiked;

  ProductItem({
    required this.image,
    required this.title,
    required this.price,
    this.offer,
    required this.rating,
    required this.isLiked,
    required this.quantity,
  });

  static final List<ProductItem> products = [
    ProductItem(
      quantity: '0',
      // image: 'images/strawberries_images.png',
      image: 'images/strawberries.png',
      title: 'Strawberries',
      price: '₹ 10',
      offer: '5% off',
      rating: '4.8',
      isLiked: false,
    ),
    ProductItem(
      quantity: '0',
      image: 'images/chips_images.png',
      title: 'Fried Chips',
      price: '₹ 12',
      rating: '4.8',
      isLiked: false,
    ),
    ProductItem(
      quantity: '0',
      image: 'images/chair_images.png',
      title: 'Modern Chair',
      price: '₹ 3599',
      offer: '25% off',
      rating: '4.8',
      isLiked: false,
    ),
    ProductItem(
      quantity: '0',
      image: 'images/washing_machine_images.png',
      title: 'LG washing machine',
      price: '₹ 45.99',
      rating: '4.8',
      isLiked: false,
    ),
  ];
}

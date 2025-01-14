import 'package:block_lesson/market/feature/cubit/product_cubit.dart';
import 'package:block_lesson/market/feature/data/product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../market_place/constants/app_constans.dart';

class ProductBody extends StatelessWidget {
  const ProductBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (BuildContext context, state) {
        if (state is ProductLoading) {
          return const SliverToBoxAdapter(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        } else if (state is ProductError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is ProductSuccess) {
          if (state.filteredProducts.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text("No products available"),
              ),
            );
          }

          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              childAspectRatio: 0.76,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: state.filteredProducts.length,
              (context, index) {
                final products = state.filteredProducts;
                return _buildProductCard(context, index, products[index]);
              },
            ),
          );
        }

        return const SliverToBoxAdapter(child: Text(''));
      },
    );
  }

  Widget _buildProductCard(
      BuildContext context, int index, ProductElement product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildProductImage(product, index, context),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(product.title),
                _buildPriceAndRating(product),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _buildAddToCartButton(product),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(
      ProductElement product, int index, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 179,
          height: 160,
          decoration: BoxDecoration(
            color: product.like ? AppConstants.bgLikeColor : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          // child: Image.asset(
          //   product.image,
          //   alignment: Alignment.center,
          //   height: 150,
          //   width: 150,
          //   fit: BoxFit.contain,
          // ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: GestureDetector(
            onTap: () {
              // context.read<ProductCubit>().toggleLike(product);
              context.read<ProductCubit>().toggleLike(product);
            },
            child: Icon(
              product.like ? Icons.favorite : Icons.favorite_border,
              color: product.like ? Colors.red : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndRating(ProductElement product) {
    return Row(
      children: [
        Text(
          "₹ ${product.price}",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              "${product.rating}",
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
    );
  }

  Widget _buildAddToCartButton(ProductElement product) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          // Проверяем, есть ли товар в корзине
          final cartItem = state.cart.firstWhere(
            (item) => item.title == product.title,
            orElse: () => product.copyWith(quantity: 0),
          );

          // Если товар добавлен в корзину (quantity > 0)
          if (cartItem.quantity > 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Кнопка "-"
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppConstants.redColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: IconButton(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      final index = state.cart
                          .indexWhere((item) => item.title == product.title);
                      if (index != -1) {
                        context
                            .read<ProductCubit>()
                            .decrementCartQuantity(index);
                      }
                    },
                    icon: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),

                // Количество товара
                Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),

                // Кнопка "+"
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppConstants.greenColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: IconButton(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        final index = state.cart
                            .indexWhere((item) => item.title == product.title);
                        if (index != -1) {
                          context
                              .read<ProductCubit>()
                              .incrementCartQuantity(index);
                        }
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                )
              ],
            );
          }
        }

        // Если товар ещё не добавлен в корзину
        return GestureDetector(
          onTap: () {
            context.read<ProductCubit>().addToCart(product);
          },
          child: Container(
            width: double.infinity,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
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
      },
    );
  }

  // Widget _buildAddToCartButton(ProductElement product) {
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Container(
  //       width: double.infinity,
  //       height: 36,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: const BorderRadius.all(
  //           Radius.circular(12),
  //         ),
  //         border: Border.all(color: AppConstants.yellowColor, width: 1),
  //       ),
  //       child: const Text(
  //         "Add to cart",
  //         style: TextStyle(
  //           color: AppConstants.yellowColor,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: const Color(0xFFE8EFF3), width: 1),
    );
  }
}

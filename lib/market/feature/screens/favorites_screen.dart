

import 'package:block_lesson/market/feature/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:block_lesson/market/feature/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          final favoriteProducts = state.likedProducts;

          if (favoriteProducts.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return ListTile(
                title: Text(product.title),
                trailing: IconButton(
                  icon: Icon(
                    product.like ? Icons.favorite : Icons.favorite_border,
                    color: product.like ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    context.read<ProductCubit>().toggleLike(product);
                  },
                ),
              );
            },
          );
        } else if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Error loading products'));
        }
      },
    );
  }
}







import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:block_lesson/market_place/model/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../product/models/product_model.dart';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> getProducts() async {
    try {
      emit(ProductLoading());
      final response = await http.get(Uri.parse(
          "https://run.mocky.io/v3/6392e3da-13f3-4e0a-8b4b-2701dc0aa2bd"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Product> products =
            data.map((e) => Product.fromJson(e)).toList();
        emit(
          ProductLoaded(
            productsElement: products.first.products,
            selectCategory: products.first.category,
            category: products,
          ),
        );
      } else {
        emit(ProductError(
            error: "Error loading products ${response.statusCode}"));
        print(response.statusCode);
      }
    } catch (e) {
      emit(ProductError(error: "Error loading products $e"));
      print(e);
    }
  }

  void selectCategory(String category) {
    final currentState = state;

    if (currentState is ProductLoaded) {
      try {
        final selectedProducts = currentState.category
            .firstWhere((item) => item.category == category);
        emit(
          currentState.copyWith(
            selectCategory: category,
            productsElement: selectedProducts.products,
          ),
        );
      } catch (e) {
        emit(ProductError(error: "Error loading products $e"));
      }
    }
  }

  void searchProductByName(String name) {}

  void likeProduct(int index) {
    final currentState = state;
    if (currentState is ProductLoaded) {
      final likedProducts = currentState.productsElement;
      likedProducts[index].like = !likedProducts[index].like;
      // currentState.productsElement[index].bgColor = currentState.productsElement[index].bgColor == Colors.white ? Colors.red : Colors.white;
      emit(currentState.copyWith(productsElement: likedProducts));
    }
  }

  // Добавляем товар в корзину
  void addToCart(String title) {
    final currentState = state;
    if (currentState is ProductLoaded) {
      final data = currentState.productsElement
          .firstWhere((item) => item.title == title);
      if(data != null) {
        cartData.add(data);
        emit(currentState.copyWith());
      }  else {
        emit(ProductError(error: "Product not add to cart"));
      }

    }
    // if (currentState is ProductLoaded) {
    //   final updatedQuantities = Map<int, int>.from(currentState.cartQuantities);
    //   updatedQuantities[index] = 1;
    //   emit(currentState.copyWith(cartQuantities: updatedQuantities));
    // }
  }

  // Увеличиваем количество товара
  void incrementQuantity(int index) {
    final currentState = state;
    // if (currentState is ProductLoaded) {
    //   final updatedQuantities = Map<int, int>.from(currentState.cartQuantities);
    //   updatedQuantities[index] = (updatedQuantities[index] ?? 0) + 1;
    //   emit(currentState.copyWith(cartQuantities: updatedQuantities));
    // }
  }

  // Уменьшаем количество товара
  void decrementQuantity(int index) {
    final currentState = state;
    // if (currentState is ProductLoaded) {
    //   final updatedQuantities = Map<int, int>.from(currentState.cartQuantities);
    //   if (updatedQuantities[index] != null && updatedQuantities[index]! > 1) {
    //     updatedQuantities[index] = updatedQuantities[index]! - 1;
    //   } else {
    //     updatedQuantities.remove(index);
    //   }
    //   emit(currentState.copyWith(cartQuantities: updatedQuantities));
    // }
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
          currentState.copywith(
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

  void likeProduct(int index) {}

  void addToCart(int index) {}
}

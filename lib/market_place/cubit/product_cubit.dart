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
          "https://run.mocky.io/v3/bd1bee29-0946-431f-b8fe-f3f65f2c8372"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Product> products =
            data.map((e) => Product.fromJson(e)).toList();
        emit(
          ProductLoaded(
            productsElement: products.first.products,
            selectCategory: products.first.category,
            products: products,
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

  void searchProductByName(String name) {}

  void likeProduct(int index) {}

  void addToCart(int index) {}
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:block_lesson/market/feature/data/product_data.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    const url = "https://run.mocky.io/v3/6392e3da-13f3-4e0a-8b4b-2701dc0aa2bd";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;

        final products = data.map((e) => Product.fromJson(e)).toList();
        final allProducts = products.expand((product) => product.products).toList();
        emit(ProductSuccess(
          products: products,
          filteredProducts: allProducts,
          selectedCategory: '',
          cart: [],
        ));
      } else {
        emit(ProductError(message: "Failed to fetch products: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ProductError(message: "An error occurred: $e"));
    }
  }

  void selectCategory(String category) {
    final currentState = state;
    if (currentState is ProductSuccess) {
      final filteredProducts = currentState.products
          .firstWhere((prod) => prod.category == category)
          .products;
      emit(currentState.copyWith(
        selectedCategory: category,
        filteredProducts: filteredProducts,
      ));
    }
  }

  void searchProduct(String query) {
    final currentState = state;
    if (currentState is ProductSuccess) {
      final filteredProducts = currentState.products
          .expand((product) => product.products)
          .where((element) =>
          element.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(currentState.copyWith(filteredProducts: filteredProducts));
    }
  }

  void toggleLike(ProductElement product) {
    final currentState = state;
    if (currentState is ProductSuccess) {
      final updatedProducts = currentState.filteredProducts.map((item) {
        if (item.title == product.title) {
          return item.copyWith(like: !item.like);
        }
        return item;
      }).toList();

      emit(currentState.copyWith(filteredProducts: updatedProducts));
    }
  }

  // void toggleLike(int index) {
  //   final currentState = state;
  //   if (currentState is ProductSuccess) {
  //     final filteredProducts = List<ProductElement>.from(currentState.filteredProducts);
  //     filteredProducts[index].like = !filteredProducts[index].like;
  //     emit(currentState.copyWith(filteredProducts: filteredProducts));
  //   }
  // }

  void addToCart(ProductElement product) {
    final currentState = state;
    if (currentState is ProductSuccess) {
      final cart = List<ProductElement>.from(currentState.cart);
      final existingProduct = cart.indexWhere((item) => item.title == product.title);

      if (existingProduct == -1) {
        cart.add(product.copyWith(quantity: 1));
      } else {
        cart[existingProduct] = cart[existingProduct]
            .copyWith(quantity: cart[existingProduct].quantity + 1);
      }
      emit(currentState.copyWith(cart: cart));
    }
  }

  void incrementCartQuantity(int index) {
    final currentState = state;
    if (currentState is ProductSuccess) {
      final cart = List<ProductElement>.from(currentState.cart);
      cart[index] = cart[index].copyWith(quantity: cart[index].quantity + 1);
      emit(currentState.copyWith(cart: cart));
    }
  }

  void decrementCartQuantity(int index) {
    final currentState = state;
    if (currentState is ProductSuccess) {
      final cart = List<ProductElement>.from(currentState.cart);
      if (cart[index].quantity > 1) {
        cart[index] = cart[index].copyWith(quantity: cart[index].quantity - 1);
      } else {
        cart.removeAt(index);
      }
      emit(currentState.copyWith(cart: cart));
    }
  }
}

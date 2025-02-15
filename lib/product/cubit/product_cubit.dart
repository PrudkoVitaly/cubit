import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial()) {
    loadProducts();
  }

  void loadProducts() {
    try {
      emit(ProductLoading());
      Future.delayed(const Duration(seconds: 1), () {
        emit(ProductLoaded(products: products));
      });
    } catch (e) {
      emit(const ProductError(error: "Error loading products"));
    }
  }

  void like(String title) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updateProduct = loadedState.products.map((item) {
        if (item.title == title) {
          return ProductModel(
            title: item.title,
            description: item.description,
            price: item.price,
            isLiked: !item.isLiked,
          );
        }
        return item;
      }).toList();
      emit(ProductLoaded(products: updateProduct));
    }
  }

  void searchProduct(String value) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;

      if (value.isEmpty) {
        // emit(ProductLoaded(products: loadedState.products));
        loadProducts();
      } else {
        final updateProducts = loadedState.products.where((item) {
          return item.title.toLowerCase().contains(value);
        }).toList();
        emit(ProductLoaded(products: updateProducts));
      }
    }
  }

  void filterProductsByPrice(
      {required double minPrice, required double maxPrice}) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final filteredProducts = loadedState.products.where((product) {
        return product.price >= minPrice && product.price <= maxPrice;
      }).toList();

      emit(ProductLoaded(products: filteredProducts));
    }
  }

  void filterProductsByPriceClear() {
    loadProducts();
  }
}

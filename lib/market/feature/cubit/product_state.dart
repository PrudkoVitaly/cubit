part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

// Success State
final class ProductSuccess extends ProductState {
  final List<Product> products;
  final List<ProductElement> filteredProducts;
  final String selectedCategory;
  final List<ProductElement> cart;
  final List<ProductElement> likedProducts;

  const ProductSuccess({
    required this.products,
    required this.filteredProducts,
    required this.selectedCategory,
    required this.cart,
    required this.likedProducts,
  });

  ProductSuccess copyWith({
    List<Product>? products,
    List<ProductElement>? filteredProducts,
    String? selectedCategory,
    List<ProductElement>? cart,
    List<ProductElement>? likedProducts,
  }) {
    return ProductSuccess(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      cart: cart ?? this.cart,
      likedProducts: likedProducts ?? this.likedProducts,
    );
  }
  @override
  List<Object> get props => [products, filteredProducts, selectedCategory, cart, likedProducts];
}

// Error State
final class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}

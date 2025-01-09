part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<Product> category;
  final List<ProductElement> productsElement;
  final String selectCategory;
  // final Map<int, int> cartQuantities;


  ProductLoaded({
    required this.productsElement,
    required this.selectCategory,
    required this.category,
    // this.cartQuantities = const {},
  });

  ProductLoaded copyWith({
    List<Product>? products,
    final List<ProductElement>? productsElement,
    final String? selectCategory,
    // Map<int, int>? cartQuantities,
  }) {
    return ProductLoaded(
      category: products ?? category,
      productsElement: productsElement ?? this.productsElement,
      selectCategory: selectCategory ?? this.selectCategory,
      // cartQuantities: cartQuantities ?? this.cartQuantities,
    );
  }
}

class ProductLike extends ProductState {
  final List<ProductElement> likeProduct;

  ProductLike({required this.likeProduct});
}

final class ProductError extends ProductState {
  final String error;

  ProductError({required this.error});
}

part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {

  final List<Product> category;
  final List<ProductElement> productsElement;
  final String selectCategory;

  ProductLoaded({
    required this.productsElement,
    required this.selectCategory,
    required this.category,
  });

  ProductLoaded copywith({
    List<Product>? products,
    final List<ProductElement>? productsElement,
    final String? selectCategory,
  }){
    return ProductLoaded(
        category: products ?? this.category,
      productsElement: productsElement ?? this.productsElement,
      selectCategory: selectCategory ?? this.selectCategory
    );
  }
}

final class ProductError extends ProductState {
  final String error;

  ProductError({required this.error});
}

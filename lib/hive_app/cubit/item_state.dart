part of 'item_cubit.dart';

sealed class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemSuccess extends ItemState {
  final List<ItemModel> items;

  const ItemSuccess({required this.items});
}

final class ItemError extends ItemState {
  final String message;

  const ItemError({required this.message});
}

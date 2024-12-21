import 'package:bloc/bloc.dart';
import 'package:block_lesson/hive_app/hive_setup/hive_setup.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../models/item_model.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final Box<ItemModel> _box;

  ItemCubit()
      : _box = Hive.box(HiveSetup.boxName),
        super(ItemInitial());

  void loadItems() {
    emit(ItemLoading());
    try {
      final items = _box.values.toList();
      emit(ItemSuccess(items: items));
    } catch (e) {
      emit(
        const ItemError(message: "Data could not be loaded"),
      );
    }
  }

  void addItem({required ItemModel value}) {
    try {
      _box.put(value.id, value);
      loadItems();
    } catch (e) {
      emit(
        const ItemError(message: "Data could not be added"),
      );
    }
  }
}

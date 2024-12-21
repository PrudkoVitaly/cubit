import 'package:hive/hive.dart';

part "item_model.g.dart";

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int value;

  ItemModel({required this.id, required this.title, required this.value});

  ItemModel copyWith({String? title, int? value}) {
    return ItemModel(
      id: id,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }
}

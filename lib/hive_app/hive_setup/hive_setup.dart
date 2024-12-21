import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/item_model.dart';

class HiveSetup {
  static const String boxName = "tasks";

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ItemModelAdapter());
    await Hive.openBox<ItemModel>(boxName);
  }
}

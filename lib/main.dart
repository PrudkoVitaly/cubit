import 'package:block_lesson/hive_app/cubit/item_cubit.dart';
import 'package:block_lesson/product/cubit/product_cubit.dart';
import 'package:block_lesson/product/screens/product_screen.dart';
import 'package:block_lesson/string_change/string_cubit.dart';
import 'package:block_lesson/string_change/string_screen.dart';
import 'package:block_lesson/task_app/task_cubit.dart';
import 'package:block_lesson/task_app/task_screen.dart';
import 'package:block_lesson/task_one_app/task_one_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_app/counter_app.dart';
import 'counter_app/counter_cubit.dart';
import 'counter_cubit/counter_one_cubit.dart';
import 'counter_cubit/counter_screen.dart';
import 'hive_app/hive_setup/hive_setup.dart';
import 'hive_app/screens/item_screen.dart';
import 'http/http_main_screen.dart';
import 'like/like_cubit.dart';
import 'like/like_screen.dart';
import 'like/test_screen.dart';
import 'task_one_app/task_one_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetup.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(create: (_) => ProductCubit()),
        BlocProvider<ItemCubit>(create: (_) => ItemCubit()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: TaskOneScreen()),
          home: HttpMainScreen()),
    );
  }
}

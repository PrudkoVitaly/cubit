import 'package:block_lesson/hive_app/cubit/item_cubit.dart';
import 'package:block_lesson/market_place/cubit/product_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'market_place/screen/home_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await HiveSetup.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(create: (_) => ProductCubit()..getProducts()),
        BlocProvider<ItemCubit>(create: (_) => ItemCubit()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: TaskOneScreen()),
          home: HomeScreen()),
    );
  }
}

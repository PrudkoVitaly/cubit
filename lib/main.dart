import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:block_lesson/hive_app/cubit/item_cubit.dart';
import 'bloc_lessons/counter/bloc/counter_bloc.dart';
import 'bloc_lessons/counter/ui/counter_screen.dart';
import 'bloc_lessons/task/bloc/task_bloc.dart';
import 'bloc_lessons/task/presentation/task_main.dart';
import 'market/feature/cubit/product_cubit.dart';
import 'market/feature/screens/home_screen.dart';
import 'market/feature/screens/main_screen.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await HiveSetup.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider для ItemCubit
        BlocProvider<ItemCubit>(create: (_) => ItemCubit()),
        // BlocProvider для ProductCubit
        BlocProvider<ProductCubit>(create: (_) => ProductCubit()..fetchProducts()),
        BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
        BlocProvider<TaskBloc>(create: (_) => TaskBloc()..add(FetchTasksEvent())),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',

        // localizationsDelegates: [
        //   S.delegate,  // Используем сгенерированные файлы локализации
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        supportedLocales: const[
          Locale('en', ''),
          Locale('ru', ''),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const MainScree(),
        // home: const CounterScreen(),
        home: const TaskMain(),
      ),
    );
  }
}

class LanguageSwitcher extends StatelessWidget {
  final Function(String) changeLanguage;

  const LanguageSwitcher({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("S.of(context).hello"), // Пример использования локализации
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                changeLanguage('en');
              },
              child: Text("S.of(context).changeLanguage"),
            ),
            ElevatedButton(
              onPressed: () {
                changeLanguage('ru');
              },
                child: Text("S.of(context).changeLanguage"),
            ),
          ],
        ),
      ),
    );
  }
}

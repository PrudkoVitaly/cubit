import 'package:block_lesson/string_change/string_cubit.dart';
import 'package:block_lesson/string_change/string_screen.dart';
import 'package:block_lesson/task_app/task_cubit.dart';
import 'package:block_lesson/task_app/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_app/counter_app.dart';
import 'counter_app/counter_cubit.dart';
import 'like/like_cubit.dart';
import 'like/like_screen.dart';
import 'like/test_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(create: (_) => CounterCubit()),
        BlocProvider<LikeCubit>(create: (_) => LikeCubit()),
        BlocProvider<StringCubit>(create: (_) => StringCubit()),
        BlocProvider<TaskCubit>(create: (_) => TaskCubit()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const TaskScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../task_one_app_cubit.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
        child: BlocBuilder<TaskOneAppCubit, TaskOneAppState>(
          builder: (context, state) {
            if(state is TaskOneCounterSuccess) {
              return Text("${state.counter}");
            }
            return const Text("0");
          },
        ),
      ),
    );
  }
}

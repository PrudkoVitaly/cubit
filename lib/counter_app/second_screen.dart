import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';

class  SecondScreen extends StatelessWidget {
  const  SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Second Screen"),
      ),
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          const Text(
            'You have pushed the button this many times:',
          ),
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) {
              return Center(child: Text("$state"));
            },
          ),
        ],
      ),
    );
  }
}

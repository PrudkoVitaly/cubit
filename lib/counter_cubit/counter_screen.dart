import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_one_cubit.dart';

class CounterOneScreen extends StatelessWidget {
  const CounterOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CounterOneCubit, CounterOneState>(
          builder: (context, state) {
            final counter = state is CounterOneInitial ? state.count : 0;
            return Center(
              child: Text("$counter"),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<CounterOneCubit>().increment();
        },
      ),
    );
  }
}

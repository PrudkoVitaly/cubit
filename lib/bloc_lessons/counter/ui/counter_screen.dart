import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(state.counter.toString());
              },
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border:  OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementEvent());
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              context
                  .read<CounterBloc>()
                  .add(CounterDecrementEvent(decrementValue: int.parse(controller.text)));
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.restart_alt),
            onPressed: () {
              context.read<CounterBloc>().add(CounterResetEvent());
            },
          ),
        ],
      ),
    );
  }
}

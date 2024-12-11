import 'package:block_lesson/string_change/string_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StringScreen extends StatelessWidget {
  const StringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<StringCubit, String>(
            builder: (context, state) {
              return Center(child: Text(state));
            },
          ),
          ElevatedButton(
            child: const Text('Change String'),
            onPressed: () {
              context.read<StringCubit>().changeString();
            },
          ),
        ],
      ),
    );
  }
}

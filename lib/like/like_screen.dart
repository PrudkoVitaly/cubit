import 'package:block_lesson/like/like_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LikeCubit, bool>(builder: (context, state) {
          return IconButton(
            onPressed: () {
              context.read<LikeCubit>().like();
            },
            icon: state
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite_border),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PreviousOrderBody extends StatelessWidget {
  const PreviousOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

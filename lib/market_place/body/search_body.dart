import 'package:flutter/material.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
      child: TextField(
          decoration: InputDecoration(
        border: OutlineInputBorder(),
      )),
    );
  }
}

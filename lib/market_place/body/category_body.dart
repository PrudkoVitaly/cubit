import 'package:flutter/material.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.only(right: 12, left: index == 0 ? 12 : 0),
            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
              ),
            ),
          );
        },
      ),
    );
  }
}

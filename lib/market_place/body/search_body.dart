import 'package:flutter/material.dart';

import '../constants/app_constans.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: SizedBox(
        height: 54,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search Anything...",
            hintStyle:  const TextStyle(
              color: Color(0xFF7D8FAB),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            fillColor: const Color(0xFFEFF1F3),
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFF7D8FAB),
              size: 22,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 1,
                  color: Colors.grey,
                  height: 25,
                ),
                Image.asset("images/phone_icon.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

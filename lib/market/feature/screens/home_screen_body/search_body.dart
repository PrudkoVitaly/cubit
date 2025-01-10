import 'package:flutter/material.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: SizedBox(
        height: 54,
        child: TextField(
          decoration: _inputDecoration(),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: "Search Anything...",
      hintStyle: _hintTextStyle,
      fillColor: _fillColor,
      filled: true,
      focusedBorder: _inputBorder,
      enabledBorder: _inputBorder,
      prefixIcon: const Icon(
        Icons.search,
        color: _iconColor,
        size: 22,
      ),
      suffixIcon: _buildSuffixIcon(),
    );
  }

  Widget _buildSuffixIcon() {
    return Row(
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
    );
  }

  // Styles
  static const TextStyle _hintTextStyle = TextStyle(
    color: Color(0xFF7D8FAB),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const Color _fillColor = Color(0xFFEFF1F3);
  static const Color _iconColor = Color(0xFF7D8FAB);

  static const OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide(color: Colors.transparent),
  );
}
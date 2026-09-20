import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final String text;
  const CategoryText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 18),
      ),
    );
  }
}

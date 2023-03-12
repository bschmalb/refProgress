import 'package:flutter/material.dart';

class LengthBar extends StatelessWidget {
  const LengthBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(.15)),
      ),
    );
  }
}

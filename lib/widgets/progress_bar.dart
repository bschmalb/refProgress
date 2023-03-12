import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.maxHeight,
    required this.progress,
    required this.color,
  });

  final double maxHeight;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: maxHeight * progress,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color.lerp(color, Colors.black, .1)!,
        ),
      ),
    );
  }
}

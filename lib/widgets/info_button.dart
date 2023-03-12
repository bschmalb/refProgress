import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoIcon extends StatelessWidget {
  const InfoIcon({
    super.key,
    required this.endDate,
    required this.onTap,
  });

  final DateTime endDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Icon(CupertinoIcons.question_circle, color: Colors.grey, size: 28),
      ),
    );
  }
}

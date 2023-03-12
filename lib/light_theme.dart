// create a light theme for the app with a headline textstyle and a body textstyle

import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(.6),
        ),
        bodyText1: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

double mainFontSize = 32;

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.blueGrey.shade50,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color(0xff383b38),
    surface: Color(0xff2f5663),
    primary: Color(0xffc18653),
    secondary: Color(0xffd8b188),
    outline: Color.fromARGB(240, 41, 38, 39),
    primaryContainer: Color.fromARGB(0, 255, 255, 255),
  ),
);

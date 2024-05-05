// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

double mainFontSize = 32;

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xFFfaf0ca),
    surface: Color(0xFFee964b),
    primary: Color(0xFF432818),
    secondary: Color(0xFFffcb77),
    outline: Color(0xFF99582a),
    tertiary: Color(0xFF001524),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(255, 53, 45, 35),
    surface: Color(0xff774936),
    primary: Color(0xfff4d35e),
    secondary: Color.fromARGB(255, 77, 48, 31),
    outline: Color(0xFFbb9457),
    tertiary: Color.fromARGB(0, 255, 255, 255),
  ),
);

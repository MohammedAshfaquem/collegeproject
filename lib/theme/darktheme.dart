import 'package:flutter/material.dart';

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    surface: Colors.black,
    primary: Colors.white,
    secondary: Colors.black,

    
  )
);

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.light,
    surface: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey.shade200,
  ),
);



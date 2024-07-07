import 'package:flutter/material.dart';

final darkMode = ThemeData.dark(useMaterial3: true).copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 201, 34, 151),
    brightness: Brightness.dark,
  ),
  textTheme: ThemeData.dark().textTheme.copyWith(
        titleLarge: ThemeData.dark().textTheme.titleLarge!.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
        titleMedium: ThemeData.dark().textTheme.titleMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
        titleSmall: ThemeData.dark().textTheme.titleSmall!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
      ),
);

final lightMode = darkMode;

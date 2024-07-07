import 'package:flutter/material.dart';

final darkMode = ThemeData.dark(useMaterial3: true).copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 156, 0, 109),
    brightness: Brightness.dark,
  ).copyWith(primary: const Color.fromARGB(255, 189, 61, 178)),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:plonde/providers/audio_provider.dart';
import 'package:plonde/providers/settings_provider.dart';
import 'package:plonde/screens/navigation_screen.dart';
import 'package:plonde/shared/themes/dark.dart';
import 'package:plonde/shared/themes/light.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AudioNotifer(),
          ),
          ChangeNotifierProvider(
            create: (context) => SettingsNotifier(),
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: context.watch<SettingsNotifier>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const NavigationScreen(),
    );
  }
}

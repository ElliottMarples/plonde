import 'package:flutter/material.dart';
import 'package:plonde/screens/library_screen.dart';
import 'package:plonde/screens/player_screen.dart';
import 'package:plonde/screens/queue_screen.dart';

// ORDER DEPENDENT
enum Pages {
  queue,
  player,
  library,
}

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final _pageController = PageController(initialPage: Pages.player.index);

  @override
  Widget build(BuildContext context) {
    final pages = [
      QueueScreen(pageController: _pageController),
      PlayerScreen(pageController: _pageController),
      LibraryScreen(pageController: _pageController),
    ];
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) => pages[index],
      ),
    );
  }
}

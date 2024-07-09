import 'package:flutter/material.dart';
import 'package:plonde/screens/navigation_screen.dart';
import 'package:plonde/screens/playlists_screen.dart';
import 'package:plonde/screens/settings_screen.dart';
import 'package:plonde/screens/songs_screen.dart';
import 'package:plonde/screens/update_song_screen.dart';

enum _LibraryScreen {
  playlists,
  songs,
}

class LibraryScreen extends StatefulWidget {
  final PageController pageController;

  const LibraryScreen({super.key, required this.pageController});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  _LibraryScreen _selectedScreen = _LibraryScreen.playlists;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Map<_LibraryScreen, Widget> screens = {
      _LibraryScreen.playlists: const PlaylistsScreen(),
      _LibraryScreen.songs: const SongsScreen(),
    };

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => widget.pageController.animateToPage(
            Pages.player.index,
            duration: const Duration(milliseconds: 256),
            curve: Curves.easeInOut,
          ),
          icon: const Icon(Icons.arrow_back),
        ),
        // backgroundColor: Colors.grey.shade900,
        // title: Text(
        //   _selectedScreen == _LibraryScreen.playlists ? 'Mixtapes' : 'Tracks',
        // ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UpdateSongScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedScreen = _LibraryScreen.playlists;
                  });
                },
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Mixtapes',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: _selectedScreen == _LibraryScreen.playlists
                          ? theme.colorScheme.primaryFixedDim
                          : null,
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                width: 1,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedScreen = _LibraryScreen.songs;
                  });
                },
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Tracks',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: _selectedScreen == _LibraryScreen.songs
                          ? theme.colorScheme.primaryFixedDim
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: screens[_selectedScreen]!),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/presentation/screens/character_list_screen.dart';
import 'package:rick_and_morty/presentation/screens/favorite_screen.dart';
import 'package:rick_and_morty/presentation/providers/theme_provider.dart';
import 'package:rick_and_morty/presentation/providers/bottom_nav_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> _screens = [
    const CharacterListScreen(),
    const FavoriteScreen(),
  ];

  static const List<String> _titles = ['Characters', 'Favorites'];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<BottomNavProvider>().currentIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeProvider>().changeTheme();
            },
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: context.read<BottomNavProvider>().setIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
        ],
      ),
      body: _screens[currentIndex],
    );
  }
}

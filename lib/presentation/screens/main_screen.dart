import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/presentation/screens/character_list_screen.dart';
import 'package:rick_and_morty/presentation/screens/favorite_screen.dart';
import 'package:rick_and_morty/presentation/providers/theme_provider.dart';
import 'package:rick_and_morty/presentation/providers/bottom_nav_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = context.watch<BottomNavProvider>();

    final screens = [CharacterListScreen(), FavoriteScreen()];
    final titles = ['Characters', 'Favorites'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[bottomNavProvider.currentIndex],
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
        currentIndex: bottomNavProvider.currentIndex,
        onTap: (val) {
          context.read<BottomNavProvider>().setIndex(val);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
        ],
      ),
      body: screens[bottomNavProvider.currentIndex],
    );
  }
}

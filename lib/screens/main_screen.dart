import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/data/dummy_data.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';
import 'package:rick_and_morty/widgets/character_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeProvider>().changeTheme();
            },
            icon: Icon(Icons.brightness_6),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
        ],
      ),
      body: ListView.builder(
        itemCount: characters.length,
        itemBuilder:
            (context, index) =>
                CharacterCard(characterModel: characters[index]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/dummy_data.dart';
import 'package:rick_and_morty/widgets/character_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CharacterCard(characterModel: character));
  }
}

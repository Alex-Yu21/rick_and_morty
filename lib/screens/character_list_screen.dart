import 'package:flutter/material.dart';
import 'package:rick_and_morty/widgets/character_card.dart';
import 'package:rick_and_morty/data/dummy_data.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder:
          (context, index) => CharacterCard(characterModel: characters[index]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({
    super.key,
    required this.characterModel,
    this.isFavorited = false,
  });
  final CharacterModel characterModel;
  final bool isFavorited;

  @override
  State<CharacterCard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(height: 100, width: 100),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.characterModel.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.secondary,
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100, width: 100),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
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
                    const SizedBox(height: 10),
                    Text(
                      widget.characterModel.status,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.star)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({
    super.key,
    required this.characterModel,
    this.isFavorit = false,
  });

  final CharacterModel characterModel;
  final bool isFavorit;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  late bool isFavorit = false;

  @override
  void initState() {
    super.initState();
    isFavorit = widget.isFavorit;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.secondary,
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                widget.characterModel.image,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.characterModel.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Origin: ${widget.characterModel.origin}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.characterModel.status} - ${widget.characterModel.species}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5, top: 5),
              child: IconButton(
                icon: Icon(
                  isFavorit ? Icons.star : Icons.star_border,
                  color:
                      isFavorit
                          ? const Color.fromARGB(255, 206, 177, 89)
                          : Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    isFavorit = !isFavorit;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

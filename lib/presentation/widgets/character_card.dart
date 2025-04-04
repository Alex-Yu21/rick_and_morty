import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({
    super.key,
    required this.character,
    this.isFavorit = false,
  });

  final Results character;
  final bool isFavorit;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  late bool isFavorit;

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
                widget.character.image ?? '',
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
                      widget.character.name ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Origin: ${widget.character.origin?.name ?? ''}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(
                            text: '${widget.character.species ?? ''} - ',
                          ),
                          TextSpan(
                            text: widget.character.status ?? '',
                            style: TextStyle(
                              color: _getStatusColor(
                                widget.character.status ?? '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 48,
              child: Align(
                alignment: Alignment.topRight,
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
            ),
          ],
        ),
      ),
    );
  }

  Color? _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return const Color.fromARGB(255, 42, 94, 43);
      case 'dead':
        return const Color.fromARGB(255, 142, 38, 31);
      default:
        return null;
    }
  }
}

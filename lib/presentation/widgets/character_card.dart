import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/presentation/providers/favorites_provider.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final Results character;

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final isFavorite = favoritesProvider.isFavorite(character.id ?? -1);

    final name = character.name ?? '';
    final origin = character.origin?.name ?? '';
    final species = character.species ?? '';
    final status = character.status ?? '';
    final image = character.image ?? '';

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
            _buildCharacterImage(image),
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
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Origin: $origin',
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
                          TextSpan(text: '$species - '),
                          TextSpan(
                            text: status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(status),
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
                child: _buildFavoriteButton(
                  context,
                  favoritesProvider,
                  isFavorite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(
    BuildContext context,
    FavoritesProvider provider,
    bool isFavorite,
  ) {
    final messenger = ScaffoldMessenger.of(context);

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.star : Icons.star_border,
        color:
            isFavorite
                ? const Color.fromARGB(255, 206, 177, 89)
                : Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {
        final wasFavorite = isFavorite;
        provider.toggleFavorite(character);

        messenger.removeCurrentSnackBar();

        messenger.showSnackBar(
          SnackBar(
            content: Text(
              wasFavorite
                  ? '${character.name ?? 'Character'} removed from favorites'
                  : '${character.name ?? 'Character'} added to favorites',
            ),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                provider.toggleFavorite(character);
              },
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      },
    );
  }

  ClipRRect _buildCharacterImage(String image) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        width: 100,
        height: 130,
        fit: BoxFit.cover,
        placeholder:
            (context, url) =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorWidget:
            (context, url, error) => Image.asset(
              'assets/pngs/not_found.png',
              width: 100,
              height: 130,
              fit: BoxFit.cover,
            ),
      ),
    );
  }

  static Color? _getStatusColor(String status) {
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/presentation/providers/favorites_provider.dart';
import 'package:rick_and_morty/presentation/widgets/character_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String _selectedSort = 'none';

  void _onSortChanged(String? value) {
    if (value == null) return;

    setState(() {
      _selectedSort = value;
    });

    final provider = context.read<FavoritesProvider>();
    switch (value) {
      case 'name':
        provider.sortByName();
        break;
      case 'status':
        provider.sortByStatus();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final favorites = favoritesProvider.favorites;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          if (favorites.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Sort by: '),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _selectedSort,
                    onChanged: _onSortChanged,
                    items: const [
                      DropdownMenuItem(value: 'none', child: Text('None')),
                      DropdownMenuItem(value: 'status', child: Text('Status')),
                      DropdownMenuItem(value: 'name', child: Text('Name')),
                    ],
                  ),
                ],
              ),
            ),
          if (favorites.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/pngs/not_found.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No favorites yet',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final character = favorites[index];
                  return Dismissible(
                    key: ValueKey(character.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.blueGrey.withAlpha(50),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.delete_outline),
                          SizedBox(width: 8),
                          Text('Delete'),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      final provider = context.read<FavoritesProvider>();
                      provider.toggleFavorite(character);

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${character.name} was removed'),
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
                    child: CharacterCard(character: character),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

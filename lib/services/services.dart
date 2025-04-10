import 'package:hive/hive.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/models/results_hive_model.dart';

abstract class FavoritesStorage {
  List<Results> getFavorites();
  bool isFavorite(int id);
  Future<void> toggleFavorite(Results character);
  Future<void> removeFavorite(int id);
  void sortByName();
  void sortByStatus();
}

class HiveFavoritesStorage implements FavoritesStorage {
  final Box<ResultsHiveModel> _box;

  List<Results> _cachedFavorites = [];

  HiveFavoritesStorage(this._box) {
    _updateCache();
  }

  void _updateCache() {
    _cachedFavorites = _box.values.map((e) => e.toResults()).toList();
  }

  @override
  List<Results> getFavorites() {
    return _cachedFavorites;
  }

  @override
  bool isFavorite(int id) => _box.containsKey(id);

  @override
  Future<void> toggleFavorite(Results character) async {
    if (character.id == null) return;

    final id = character.id!;
    if (isFavorite(id)) {
      await _box.delete(id);
    } else {
      await _box.put(id, ResultsHiveModel.fromResults(character));
    }

    _updateCache();
  }

  @override
  Future<void> removeFavorite(int id) async {
    await _box.delete(id);
    _updateCache();
  }

  @override
  void sortByName() {
    _cachedFavorites.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
  }

  @override
  void sortByStatus() {
    _cachedFavorites.sort((a, b) => (a.status ?? '').compareTo(b.status ?? ''));
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/models/results_hive_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final Box<ResultsHiveModel> _box = Hive.box<ResultsHiveModel>('favorites');

  List<Results> _cachedFavorites = [];

  FavoritesProvider() {
    _cachedFavorites = _box.values.map((e) => e.toResults()).toList();
  }

  List<Results> get favorites => _cachedFavorites;

  bool isFavorite(int id) => _box.containsKey(id);

  void _updateCache() {
    _cachedFavorites = _box.values.map((e) => e.toResults()).toList();
    notifyListeners();
  }

  void toggleFavorite(Results character) {
    if (character.id == null) return;

    final characterId = character.id!;
    if (isFavorite(characterId)) {
      _box.delete(characterId);
    } else {
      _box.put(characterId, ResultsHiveModel.fromResults(character));
    }

    _updateCache();
  }

  void removeFavorite(int id) {
    _box.delete(id);
    _updateCache();
  }

  void sortByName() {
    _cachedFavorites.sort(
      (Results a, Results b) => (a.name ?? '').compareTo(b.name ?? ''),
    );
    notifyListeners();
  }

  void sortByStatus() {
    _cachedFavorites.sort(
      (Results a, Results b) => (a.status ?? '').compareTo(b.status ?? ''),
    );
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/models/results_hive_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final Box<ResultsHiveModel> _box = Hive.box<ResultsHiveModel>('favorites');

  List<Results> get favorites => _box.values.map((e) => e.toResults()).toList();

  bool isFavorite(int id) => _box.containsKey(id);

  void toggleFavorite(Results character) {
    if (character.id == null) return;

    final characterId = character.id!;
    if (isFavorite(characterId)) {
      _box.delete(characterId);
    } else {
      _box.put(characterId, ResultsHiveModel.fromResults(character));
    }
    notifyListeners();
  }

  void removeFavorite(int id) {
    _box.delete(id);
    notifyListeners();
  }

  void sortByName() {
    final sorted =
        _box.values.toList()..sort((a, b) => a.name.compareTo(b.name));
    _box.clear();
    for (var c in sorted) {
      _box.put(c.id, c);
    }
    notifyListeners();
  }

  void sortByStatus() {
    final sorted =
        _box.values.toList()..sort((a, b) => a.status.compareTo(b.status));
    _box.clear();
    for (var c in sorted) {
      _box.put(c.id, c);
    }
    notifyListeners();
  }
}

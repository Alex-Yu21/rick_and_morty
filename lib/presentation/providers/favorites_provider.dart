import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/services/services.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesStorage storage;

  FavoritesProvider(this.storage);

  List<Results> get favorites => storage.getFavorites();

  bool isFavorite(int id) => storage.isFavorite(id);

  Future<void> toggleFavorite(Results character) async {
    await storage.toggleFavorite(character);
    notifyListeners();
  }

  Future<void> removeFavorite(int id) async {
    await storage.removeFavorite(id);
    notifyListeners();
  }

  void sortByName() {
    storage.sortByName();
    notifyListeners();
  }

  void sortByStatus() {
    storage.sortByStatus();
    notifyListeners();
  }
}

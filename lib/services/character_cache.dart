import 'package:rick_and_morty/models/character.dart';

abstract class CharacterCache {
  List<Results> getCached();
  Future<void> cacheResults(List<Results> results);
}

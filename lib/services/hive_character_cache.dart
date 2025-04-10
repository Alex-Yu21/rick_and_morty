import 'package:hive/hive.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/models/results_hive_model.dart';
import 'package:rick_and_morty/services/character_cache.dart';

class HiveCharacterCache implements CharacterCache {
  final Box<ResultsHiveModel> box;

  HiveCharacterCache(this.box);

  @override
  List<Results> getCached() {
    return box.values.map((e) => e.toResults()).toList();
  }

  @override
  Future<void> cacheResults(List<Results> results) async {
    for (var c in results) {
      if (c.id != null) {
        await box.put(c.id, ResultsHiveModel.fromResults(c));
      }
    }
  }
}

import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty/models/results_hive_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ResultsHiveModelAdapter());

  await Hive.openBox<ResultsHiveModel>('favorites');
  await Hive.openBox<ResultsHiveModel>('cached_chars');
}

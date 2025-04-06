import 'package:hive/hive.dart';
import 'package:rick_and_morty/models/character.dart';

part 'results_hive_model.g.dart';

@HiveType(typeId: 0)
class ResultsHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String species;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final String originName;

  ResultsHiveModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.originName,
  });

  factory ResultsHiveModel.fromResults(Results character) {
    return ResultsHiveModel(
      id: character.id ?? 0,
      name: character.name ?? '',
      status: character.status ?? '',
      species: character.species ?? '',
      image: character.image ?? '',
      originName: character.origin?.name ?? '',
    );
  }

  Results toResults() {
    return Results(
      id: id,
      name: name,
      status: status,
      species: species,
      image: image,
      origin: Origin(name: originName),
    );
  }
}

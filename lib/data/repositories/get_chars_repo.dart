import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/services/api_client.dart';

class GetCharsRepo {
  final ApiClient api;

  GetCharsRepo({required this.api});

  Future<CharacterModel> getData({int page = 1}) async {
    final response = await api.get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: {'page': page},
    );

    return CharacterModel.fromJson(response);
  }
}

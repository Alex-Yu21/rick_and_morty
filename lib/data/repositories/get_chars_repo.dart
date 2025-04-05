import 'package:dio/dio.dart';
import 'package:rick_and_morty/models/character.dart';

class GetCharsRepo {
  GetCharsRepo({required this.dio});

  final Dio dio;

  Future<CharacterModel> getData() async {
    final Response response = await dio.get('/character');
    return CharacterModel.fromJson(response.data);
  }
}

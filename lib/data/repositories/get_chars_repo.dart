import 'package:dio/dio.dart';
import 'package:rick_and_morty/models/character.dart';

class GetCharsRepo {
  GetCharsRepo({required this.dio});

  final Dio dio;

  Future<CharacterModel> getData({int page = 1}) async {
    try {
      final response = await dio.get('/character?page=$page');
      return CharacterModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}

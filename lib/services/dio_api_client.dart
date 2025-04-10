import 'package:dio/dio.dart';
import 'package:rick_and_morty/services/api_client.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient(this._dio);

  @override
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(url, queryParameters: queryParameters);
    return response.data as Map<String, dynamic>;
  }
}

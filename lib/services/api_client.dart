abstract class ApiClient {
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  });
}

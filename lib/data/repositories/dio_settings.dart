import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

class DioSettings {
  late final Dio dio;

  DioSettings() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api',
        contentType: "application/json",
        headers: {"Accept": "application/json"},
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    final interceptors = dio.interceptors;
    interceptors.clear();

    if (kDebugMode) {
      interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onError: (error, handler) => handler.next(error),
        onResponse: (response, handler) => handler.next(response),
      ),
    );
  }
}

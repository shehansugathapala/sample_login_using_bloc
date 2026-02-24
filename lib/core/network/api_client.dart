import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'reqres_a6ab666b0c7449b383010eb3af7d6631',
        'User-Agent': 'flutter-login-app',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
}
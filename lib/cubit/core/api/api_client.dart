import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.example.com', // غيّرها حسب الـ API
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(ApiInterceptors());

  static Dio get instance => _dio;
}

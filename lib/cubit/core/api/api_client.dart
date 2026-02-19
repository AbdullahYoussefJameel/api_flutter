import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.example.com', // لا تنسَ وضع رابط السيرفر الخاص بك هنا
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )
    ..interceptors.add(ApiInterceptors())
    // أضف هذا السطر لمراقبة الطلبات في الـ Console أثناء البرمجة
    ..interceptors.add(LogInterceptor(
      requestBody: true, 
      responseBody: true,
      logPrint: (object) => print('API_LOG: $object'),
    ));

  static Dio get instance => _dio;
}
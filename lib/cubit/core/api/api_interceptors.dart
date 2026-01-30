import 'package:dio/dio.dart';
import 'package:api_flutter/cashe/cashe_helper.dart';
import 'api_keys.dart';

/// Interceptor to add Authorization header automatically
class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper.getString(ApiKeys.token);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err); // Can be extended for global error handling
  }
}

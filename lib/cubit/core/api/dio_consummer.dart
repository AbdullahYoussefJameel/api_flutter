import 'package:api_flutter/cubit/core/api/end_ponits.dart';
import 'package:api_flutter/cubit/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import 'api_consummer.dart';
import 'api_interceptors.dart';

/// Implementation of ApiConsumer using Dio
class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..headers = {'Accept': 'application/json'};

    dio.interceptors.add(ApiInterceptors());

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
  @override
  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data as T;
    } on DioException catch (e) {
      return handleDioException<T>(e);
    }
  }

  @override
  Future<T> post<T>(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data as T;
    } on DioException catch (e) {
      return handleDioException<T>(e);
    }
  }

  @override
  Future<T> patch<T>(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data as T;
    } on DioException catch (e) {
      return handleDioException<T>(e);
    }
  }

  @override
  Future<T> delete<T>(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data as T;
    } on DioException catch (e) {
      return handleDioException<T>(e);
    }
  }
}

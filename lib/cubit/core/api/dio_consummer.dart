import 'package:api_flutter/cubit/core/api/api_consummer.dart';
import 'package:api_flutter/cubit/core/api/api_interceptors.dart';
import 'package:api_flutter/cubit/core/errors/errore_model.dart';
import 'package:api_flutter/cubit/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

class DioConsummer extends ApiConsummer {
  final Dio dio;

  DioConsummer({required this.dio}) {
    dio.options.baseUrl = "https://food-api-omega.vercel.app/api/v1/";
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }
  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isformdata ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExcptions(e);
    }
  }

  void handleDioExcptions(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServereException(
          errModel: ErroreModel.fromJson(e.response!.data),
        );
      case DioExceptionType.sendTimeout:
        throw ServereException(
          errModel: ErroreModel.fromJson(e.response!.data),
        );
      case DioExceptionType.receiveTimeout:
        throw ServereException(
          errModel: ErroreModel.fromJson(e.response!.data),
        );
      case DioExceptionType.badCertificate:
        throw ServereException(
          errModel: ErroreModel.fromJson(e.response!.data),
        );
      case DioExceptionType.cancel:
        throw ServereException(
          errModel: ErroreModel.fromJson(e.response!.data),
        );
      case DioExceptionType.connectionError:
        throw ServereException(
          errModel: ErroreModel.fromJson(e.response!.data),
        );
      case DioExceptionType.unknown:
        throw ServereException(
          errModel: ErroreModel.fromJson(e.response!.data),
        );
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400: //bad request
            throw ServereException(
              errModel: ErroreModel.fromJson(e.response!.data),
            );
          case 401: //unauthorized
            throw ServereException(
              errModel: ErroreModel.fromJson(e.response!.data),
            );
          case 403: //forbidden
            throw ServereException(
              errModel: ErroreModel.fromJson(e.response!.data),
            );
          case 404: //not found
            throw ServereException(
              errModel: ErroreModel.fromJson(e.response!.data),
            );
          case 409: //cofficient
            throw ServereException(
              errModel: ErroreModel.fromJson(e.response!.data),
            );
          case 422: //unprocessable entity
            throw ServereException(
              errModel: ErroreModel.fromJson(e.response!.data),
            );
          case 504: //server excption
            throw ServereException(
              errModel: ErroreModel.fromJson(e.response!.data),
            );
        }
    }
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExcptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: isformdata ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExcptions(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: isformdata ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExcptions(e);
    }
  }
}

import 'package:api_flutter/cubit/core/errors/errore_model.dart';
import 'package:dio/dio.dart';

class ServereException implements Exception {
  final ErroreModel errModel;

  ServereException({required this.errModel});
}

void handleDioExcptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServereException(errModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServereException(errModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServereException(errModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServereException(errModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServereException(errModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServereException(errModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServereException(errModel: ErroreModel.fromJson(e.response!.data));
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

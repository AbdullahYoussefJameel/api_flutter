import 'errore_model.dart';
import 'package:dio/dio.dart';

/// Exception class for API / Server errors
class ServerException implements Exception {
  final ErrorModel error;

  ServerException({required this.error});

  @override
  String toString() =>
      'ServerException: ${error.message} (status: ${error.statusCode})';
}

/// Handles DioException and converts it to ServerException
T handleDioException<T>(DioException e) {
  final data = e.response?.data;

  if (data is Map<String, dynamic>) {
    throw ServerException(error: ErrorModel.fromJson(data));
  } else {
    throw ServerException(
      error: ErrorModel(
        message: data?.toString() ?? e.message ?? 'Network error',
        statusCode: e.response?.statusCode ?? 0,
      ),
    );
  }
}

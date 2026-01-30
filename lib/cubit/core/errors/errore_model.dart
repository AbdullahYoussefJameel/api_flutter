/// Model for error responses
class ErrorModel {
  final String message;
  final int statusCode;

  ErrorModel({required this.message, required this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'] ?? json['errorMessage'] ?? 'Unknown error',
      statusCode: json['status'] ?? 0,
    );
  }
}

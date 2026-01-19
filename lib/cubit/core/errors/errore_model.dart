import 'package:api_flutter/cubit/core/api/end_ponits.dart';

class ErroreModel {
  final int status;
  final String erroreMassage;

  ErroreModel({required this.status, required this.erroreMassage});
  factory ErroreModel.fromJson(Map<String, dynamic> jsonData) {
    return ErroreModel(
      status: jsonData[ApiKey.status],
      erroreMassage: jsonData[ApiKey.errorMassage],
    );
  }
}

import 'package:api_flutter/cubit/core/api/api_keys.dart';

class SignUpModel {
  final String message;

  SignUpModel({required this.message});

  factory SignUpModel.fromJson(Map<String, dynamic> jsonData) {
    return SignUpModel(
      message: jsonData[ApiKeys.message]?.toString() ?? "No message received",
    );
  }
}

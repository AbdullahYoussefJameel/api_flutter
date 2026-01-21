import 'package:api_flutter/cubit/core/api/end_ponits.dart';

class SignUpModel {
  final String message;

  SignUpModel({required this.message});
  factory SignUpModel.fromJson(Map<String, dynamic> jsonData) {
    return SignUpModel(
      message: jsonData[ApiKey.message]?.toString() ?? "No message received",
    );
  }
}


// import 'package:api_flutter/cubit/core/api/end_ponits.dart';

// class SignUpModel {
//   final String message;

//   SignUpModel({required this.message});
//   factory SignUpModel.fromJson(Map<String, dynamic> jsonData) {
//     return SignUpModel(message: jsonData[ApiKey.message]);
//   }
// }


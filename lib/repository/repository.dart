import 'package:api_flutter/cache/cache_helper.dart';
import 'package:api_flutter/cubit/core/api/api_consummer.dart';
import 'package:api_flutter/cubit/core/api/end_ponits.dart';
import 'package:api_flutter/cubit/core/api/api_keys.dart';
import 'package:api_flutter/cubit/core/errors/exceptions.dart';
import 'package:api_flutter/cubit/core/functions/multipart_helper.dart';
import 'package:api_flutter/models/sign_in_model.dart';
import 'package:api_flutter/models/sign_up_model.dart';
import 'package:api_flutter/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});

  /// ===== GET USER PROFILE =====
  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final userId = CacheHelper.getData(key:  ApiKeys.id);
      if (userId == null) return Left("User ID not found in cache");

      final response = await api.get(EndPoints.getUser(userId));
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.error.message);
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }

  /// ===== DELETE USER =====
  Future<Either<String, String>> deleteUser() async {
    try {
      final userId = CacheHelper.getData(key:  ApiKeys.id);
      if (userId == null) return Left("User ID not found in cache");

      await api.delete(EndPoints.deleteUser(userId));

      // Remove token and ID from cache
      await CacheHelper.removeData(key:  ApiKeys.token);
      await CacheHelper.removeData(key:  ApiKeys.id);

      return const Right("Account deleted successfully");
    } on ServerException catch (e) {
      return Left(e.error.message);
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }

  /// ===== UPDATE USER PROFILE =====
  Future<Either<String, UserModel>> updateUserProfile({
    String? name,
    String? phone,
    XFile? profilePic,
  }) async {
    try {
      final userId = CacheHelper.getData(key:  ApiKeys.id);
      if (userId == null) return Left("User ID not found in cache");

      final data = <String, dynamic>{};

      if (name != null) data[ApiKeys.name] = name;
      if (phone != null) data[ApiKeys.phone] = phone;
      if (profilePic != null) {
        final uploadedImage = await MultipartHelper.fromFilePath(
          profilePic.path,
        );
        data[ApiKeys.profilePic] = uploadedImage;
      }

      // Use FormData if there is an image
      dynamic body = profilePic != null ? FormData.fromMap(data) : data;

      final response = await api.patch(
        EndPoints.updateUser(userId),
        body: body,
      );

      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.error.message);
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }

  /// ===== SIGN UP =====
  Future<Either<String, SignUpModel>> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    XFile? profilePic,
    Map<String, dynamic>? location,
  }) async {
    try {
      final data = {
        ApiKeys.name: name,
        ApiKeys.phone: phone,
        ApiKeys.email: email,
        ApiKeys.password: password,
        ApiKeys.confirmPassword: confirmPassword,
        ApiKeys.location:
            location ??
            {
              "name": "Unknown",
              "address": "Unknown",
              "coordinates": [0.0, 0.0],
            },
      };

      if (profilePic != null) {
        final uploadedImage = await MultipartHelper.fromFilePath(
          profilePic.path,
        );
        data[ApiKeys.profilePic] = uploadedImage;
      }

      final body = profilePic != null ? FormData.fromMap(data) : data;

      final response = await api.post(EndPoints.signUp, body: body);

      return Right(SignUpModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.error.message);
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }

  /// ===== SIGN IN =====
  Future<Either<String, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        EndPoints.signIn,
        body: {ApiKeys.email: email, ApiKeys.password: password},
      );

      final user = SignInModel.fromJson(response);

      // Save token and ID after decoding JWT
      final decodedToken = JwtDecoder.decode(user.token);
      final userId = decodedToken[ApiKeys.id];
      if (userId == null) return Left("Invalid token: ID missing");

      await CacheHelper.saveData(key: ApiKeys.token, value: user.token);
      await CacheHelper.saveData(key: ApiKeys.id, value: userId);

      return Right(user);
    } on ServerException catch (e) {
      return Left(e.error.message);
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }
}

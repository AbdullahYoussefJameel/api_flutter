import 'package:api_flutter/cashe/cashe_helper.dart';
import 'package:api_flutter/cubit/core/api/api_consummer.dart';
import 'package:api_flutter/cubit/core/api/end_ponits.dart';
import 'package:api_flutter/cubit/core/errors/exceptions.dart';
import 'package:api_flutter/cubit/core/functions/upload_image_to_api.dart';
import 'package:api_flutter/models/sign_in_model.dart';
import 'package:api_flutter/models/sign_up_model.dart';
import 'package:api_flutter/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepository {
  final ApiConsummer api;

  UserRepository({required this.api});

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(
        EndPonits.getUserDataEndPoint(CacheHelper().getData(key: ApiKey.id)),
      );
      return Right(UserModel.fromJson(response));
    } on ServereException catch (e) {
      return Left(e.errModel.erroreMassage);
    }
  }

  Future<Either<String, String>> deleteUser() async {
    try {
      await api.delete(
        EndPonits.deleteUserEndPoint(CacheHelper().getData(key: ApiKey.id)),
      );

      await CacheHelper().removeData(key: ApiKey.token);
      await CacheHelper().removeData(key: ApiKey.id);

      return const Right("تم حذف الحساب بنجاح");
    } on ServereException catch (e) {
      return Left(e.errModel.erroreMassage);
    }
  }

  Future<Either<String, UserModel>> updateUserProfile({
    String? name,
    String? phone,
    XFile? profilePic,
  }) async {
    try {
      final data = <String, dynamic>{};

      if (name != null) data[ApiKey.name] = name;
      if (phone != null) data[ApiKey.phone] = phone;
      if (profilePic != null) {
        data[ApiKey.profilePic] = await uploadImageToAPI(profilePic);
      }

      final response = await api.patch(
        EndPonits.updateUserEndPoint(CacheHelper().getData(key: ApiKey.id)),
        isformdata: true,
        data: data,
      );

      return Right(UserModel.fromJson(response));
    } on ServereException catch (e) {
      return Left(e.errModel.erroreMassage);
    }
  }

  Future<Either<String, SignUpModel>> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmpassword,

    required XFile profilePic,
  }) async {
    try {
      final response = await api.post(
        EndPonits.signUp,
        isformdata: true,
        data: {
          ApiKey.name: name,
          ApiKey.phone: phone,
          ApiKey.email: email,
          ApiKey.password: password,
          ApiKey.confirmPassword: confirmpassword,
          ApiKey.location:
              '{"{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}"}',
          ApiKey.profilePic: await uploadImageToAPI(profilePic),
        },
      );
      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServereException catch (e) {
      return Left(e.errModel.erroreMassage);
    }
  }

  Future<Either<String, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // إرسال الطلب
      final response = await api.post(
        EndPonits.signIn,
        data: {ApiKey.email: email, ApiKey.password: password},
      );

      // تحويل الاستجابة إلى نموذج
      final user = SignInModel.fromJson(response);

      // فك التوكن وحفظ البيانات
      final decodedToken = JwtDecoder.decode(user.token);
      await CacheHelper().saveData(key: ApiKey.token, value: user.token);
      await CacheHelper().saveData(
        key: ApiKey.id,
        value: decodedToken[ApiKey.id],
      );
      return Right(user);
    } on ServereException catch (e) {
      return Left(e.errModel.erroreMassage);
    }
  }
}

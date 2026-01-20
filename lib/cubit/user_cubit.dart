import 'package:api_flutter/cashe/cashe_helper.dart';
import 'package:api_flutter/cubit/core/api/api_consummer.dart';
import 'package:api_flutter/cubit/core/api/end_ponits.dart';
import 'package:api_flutter/cubit/core/errors/exceptions.dart';
import 'package:api_flutter/models/sign_in_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_flutter/cubit/user_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsummer api;

  // Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  // Sign in email & password
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  // Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  // Profile Pic
  XFile? profilePic;
  // Sign up fields
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpPhoneNumber = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  SignInModel? user;

  // ================= SIGN IN =================
  signIn() async {
    try {
      emit(SignInLoading());

      // إرسال الطلب
      final response = await api.post(
        EndPonits.signIn,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );

      // تحويل الاستجابة إلى نموذج
      user = SignInModel.fromJson(response);

      // التحقق من وجود التوكن
      if (user == null || user!.token.isEmpty) {
        emit(
          SignInFailure(errMessage: "User not found or invalid credentials"),
        );
        return;
      }

      // فك التوكن وحفظ البيانات
      final decodedToken = JwtDecoder.decode(user!.token);
      await CacheHelper().saveData(key: ApiKey.token, value: user!.token);
      await CacheHelper().saveData(
        key: ApiKey.id,
        value: decodedToken[ApiKey.id],
      );

      emit(SignInSuccess());
    } on ServereException catch (e) {
      // إذا كان الخطأ من السيرفر
      emit(SignInFailure(errMessage: e.errModel.erroreMassage));
    } on DioError catch (e) {
      // إذا لم يستطع الاتصال بالـ API
      emit(SignInFailure(errMessage: "Network error, please try again"));
    } catch (e) {
      // أي خطأ غير متوقع
      emit(SignInFailure(errMessage: "Unexpected error: $e"));
    }
  }

  // ================= SIGN UP =================
  // يمكنك إضافة دالة التسجيل هنا بنفس النمط لاحقًا
}

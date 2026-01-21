//import 'package:api_flutter/cashe/cashe_helper.dart';
//import 'package:api_flutter/cubit/core/api/api_consummer.dart';
//import 'package:api_flutter/cubit/core/api/end_ponits.dart';
//import 'package:api_flutter/cubit/core/errors/exceptions.dart';
//import 'package:api_flutter/cubit/core/functions/upload_image_to_api.dart';
import 'package:api_flutter/models/sign_in_model.dart';
//import 'package:api_flutter/models/sign_up_model.dart';
//import 'package:api_flutter/models/user_model.dart';
import 'package:api_flutter/repositary/repositry.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_flutter/cubit/user_state.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:jwt_decoder/jwt_decoder.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(UserInitial());
  final UserRepository userRepository;

  //UserCubit(this.api) : super(UserInitial());
  // final ApiConsummer api;

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

  uploadprofilepic(XFile image) {
    profilePic = image;
    emit(UpLoadProfileopic());
  }

  signUp() async {
    emit(SignUpLoading());
    final response = await userRepository.signUp(
      name: signUpName.text,
      phone: signUpPhoneNumber.text,
      email: signUpEmail.text,
      password: signUpPassword.text,
      confirmpassword: confirmPassword.text,
      profilePic: profilePic!,
    );
    response.fold(
      (errMassage) => emit(SignUpFailure(errMessage: errMassage)),
      (signUpModel) => emit(SignUpSuccess(massage: signUpModel.message)),
    );
  }

  signIn() async {
    emit(SignInLoading());
    final response = await userRepository.signIn(
      email: signUpEmail.text,
      password: signUpPassword.text,
    );
    response.fold(
      (errMassage) => emit(SignInFailure(errMessage: errMassage)),
      (signUpModel) => emit(SignInSuccess()),
    );
  }

  getUserProfile() async {
    emit(GetUserLoading());
    final response = await userRepository.getUserProfile();
    response.fold(
      (errMassage) => emit(GetUserFailure(errMessage: errMassage)),
      (user) => emit(GetUserSuccess(user: user)),
    );
  }

  // getUserProfile() async {
  // try {
  //   emit(GetUserLoading());
  //   final response = await api.get(
  //     EndPonits.getUserDataEndPoint(CacheHelper().getData(key: ApiKey.id)),
  //   );
  //   emit(GetUserSuccess(user: UserModel.fromJson(response)));
  // } on ServereException catch (e) {
  //   emit(GetUserFailure(errMessage: e.errModel.erroreMassage));
  // }
  // }

  //signUp() async {
  // try {
  //   emit(SignUpLoading());
  //   final response = await api.post(
  //     EndPonits.signUp,
  //     isformdata: true,
  //     data: {
  //       ApiKey.name: signUpName.text,
  //       ApiKey.phone: signUpPhoneNumber.text,
  //       ApiKey.email: signUpEmail.text,
  //       ApiKey.password: signUpPassword.text,
  //       ApiKey.confirmPassword: confirmPassword.text,
  //       ApiKey.location:
  //           '{"{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}"}',
  //       ApiKey.profilePic: await uploadImageToAPI(profilePic!),
  //     },
  //   );
  //   final signUpModel = SignUpModel.fromJson(response);

  //   emit(SignUpSuccess(massage: signUpModel.message));
  // } on ServereException catch (e) {
  //   emit(SignUpFailure(errMessage: e.errModel.erroreMassage));
  // } on DioError catch (e) {
  //   emit(SignUpFailure(errMessage: "Network error, please try again"));
  // } catch (e) {
  //   emit(SignUpFailure(errMessage: "Unexpected error: $e"));
  // }
  // }

  //signIn() async {
  // try {
  //   emit(SignInLoading());

  //   // إرسال الطلب
  //   final response = await api.post(
  //     EndPonits.signIn,
  //     data: {
  //       ApiKey.email: signInEmail.text,
  //       ApiKey.password: signInPassword.text,
  //     },
  //   );

  //   // تحويل الاستجابة إلى نموذج
  //   user = SignInModel.fromJson(response);

  //   // التحقق من وجود التوكن
  //   if (user == null || user!.token.isEmpty) {
  //     emit(
  //       SignInFailure(errMessage: "User not found or invalid credentials"),
  //     );
  //     return;
  //   }

  //   // فك التوكن وحفظ البيانات
  //   final decodedToken = JwtDecoder.decode(user!.token);
  //   await CacheHelper().saveData(key: ApiKey.token, value: user!.token);
  //   await CacheHelper().saveData(
  //     key: ApiKey.id,
  //     value: decodedToken[ApiKey.id],
  //   );

  //   emit(SignInSuccess());
  // } on ServereException catch (e) {
  //   emit(SignInFailure(errMessage: e.errModel.erroreMassage));
  // } on DioError catch (e) {
  //   emit(SignInFailure(errMessage: "Network error, please try again"));
  // } catch (e) {
  //   emit(SignInFailure(errMessage: "Unexpected error: $e"));
  // }
  //}
}

import 'package:api_flutter/cashe/cashe_helper.dart';
import 'package:api_flutter/models/sign_in_model.dart';
import 'package:api_flutter/models/user_model.dart';
import 'package:api_flutter/repositary/repositry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_flutter/cubit/user_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:api_flutter/cubit/core/api/api_keys.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(const UserInitial());

  // ---------- Sign In Fields ----------
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final TextEditingController signInEmail = TextEditingController();
  final TextEditingController signInPassword = TextEditingController();

  // ---------- Sign Up Fields ----------
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController signUpName = TextEditingController();
  final TextEditingController signUpPhoneNumber = TextEditingController();
  final TextEditingController signUpEmail = TextEditingController();
  final TextEditingController signUpPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  XFile? profilePic;

  // ---------- User Data ----------
  SignInModel? user;

  // ---------- Upload Profile Picture ----------
  void uploadProfilePic(XFile image) {
    profilePic = image;
    emit(const UploadProfilePic());
  }

  // ---------- Sign Up Function ----------
  Future<void> signUp() async {
    if (profilePic == null) {
      emit(SignUpFailure(errorMessage: "Profile picture is required"));
      return;
    }

    emit(const SignUpLoading());

    final response = await userRepository.signUp(
      name: signUpName.text,
      phone: signUpPhoneNumber.text,
      email: signUpEmail.text,
      password: signUpPassword.text,
      confirmPassword: confirmPassword.text,
      profilePic: profilePic!,
    );

    response.fold(
      (errMessage) => emit(SignUpFailure(errorMessage: errMessage)),
      (signUpModel) => emit(SignUpSuccess(message: signUpModel.message)),
    );
  }

  // ---------- Sign In Function ----------
  Future<void> signIn() async {
    emit(const SignInLoading());

    final response = await userRepository.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );

    response.fold(
      (errMessage) => emit(SignInFailure(errorMessage: errMessage)),
      (signInModel) async {
        user = signInModel;

        if (user!.token.isEmpty) {
          emit(SignInFailure(errorMessage: "Invalid credentials"));
          return;
        }

        // Decode token to get user ID
        Map<String, dynamic> decodedToken = JwtDecoder.decode(user!.token);
        String userId = decodedToken[ApiKeys.id] ?? '';

        // Save token and userId in cache
        await CacheHelper.save(key: ApiKeys.token, value: user!.token);
        await CacheHelper.save(key: ApiKeys.id, value: userId);

        emit(const SignInSuccess());
      },
    );
  }

  // ---------- Get User Profile ----------
  Future<void> getUserProfile() async {
    emit(const GetUserLoading());

    final response = await userRepository.getUserProfile();

    response.fold(
      (errMessage) => emit(GetUserFailure(errorMessage: errMessage)),
      (user) => emit(GetUserSuccess(user: user)),
    );
  }

  // ---------- Delete User ----------
  Future<void> deleteUser() async {
    emit(const GetUserLoading());

    final response = await userRepository.deleteUser();

    response.fold(
      (errMessage) => emit(GetUserFailure(errorMessage: errMessage)),
      (message) async {
        // Clear cached data
        await CacheHelper.clear();
        // Use an empty UserModel instance
        emit(GetUserSuccess(user: UserModel.empty()));
      },
    );
  }
}

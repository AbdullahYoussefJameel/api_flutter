import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

// Sign In
class SignInLoading extends UserState {
  const SignInLoading();
}

class SignInSuccess extends UserState {
  const SignInSuccess();
}

class SignInFailure extends UserState {
  final String errorMessage;
  const SignInFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// Sign Up
class SignUpLoading extends UserState {
  const SignUpLoading();
}

class SignUpSuccess extends UserState {
  final String message;
  const SignUpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends UserState {
  final String errorMessage;
  const SignUpFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// Profile Picture
class UploadProfilePic extends UserState {
  const UploadProfilePic();
}

// Get User
class GetUserLoading extends UserState {
  const GetUserLoading();
}

class GetUserSuccess extends UserState {
  final UserModel user;
  const GetUserSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetUserFailure extends UserState {
  final String errorMessage;
  const GetUserFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

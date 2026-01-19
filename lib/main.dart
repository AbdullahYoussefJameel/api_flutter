import 'package:api_flutter/cubit/core/api/dio_consummer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_flutter/cubit/user_cubit.dart';
import 'package:api_flutter/screens/sign_in_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserCubit(DioConsummer(dio: Dio())),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

import 'package:api_flutter/cashe/cashe_helper.dart';
import 'package:api_flutter/cubit/core/api/dio_consummer.dart';
import 'package:api_flutter/repositary/repositry.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_flutter/cubit/user_cubit.dart';
import 'package:api_flutter/screens/sign_in_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(
    BlocProvider(
      create: (context) =>
          UserCubit(UserRepository(api: DioConsummer(dio: Dio()))),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'cubit/user_cubit.dart';
import 'repository/repository.dart';
import 'cache/cache_helper.dart';
import 'cubit/core/api/dio_consummer.dart';
import 'screens/sign_in_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  final dio = Dio();
  final apiConsumer = DioConsumer(dio: dio);
  final userRepo = UserRepository(api: apiConsumer);

  runApp(
    BlocProvider(create: (_) => UserCubit(userRepo), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignInScreen(),
    );
  }
}

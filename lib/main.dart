import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_auth_bloc/app_routes.dart';
import 'package:flutter_application_auth_bloc/cubit/auth_cubit.dart';
import 'package:flutter_application_auth_bloc/views/forgot_password/forgot_password.dart';
import 'package:flutter_application_auth_bloc/views/home/home.dart';
import 'package:flutter_application_auth_bloc/views/login/login.dart';
import 'package:flutter_application_auth_bloc/views/sign_up/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Basic Login',
        theme: ThemeData(primarySwatch: Colors.red),
        initialRoute: AppRoutes.login,
        routes: <String, WidgetBuilder>{
          AppRoutes.login: (context) => const LoginView(),
          AppRoutes.home: (context) => const HomeView(),
          AppRoutes.forgotPassword: (context) => const ForgotPasswordView(),
          AppRoutes.signup: (context) => const SignUpView(),
        },
      ),
    );
  }
}

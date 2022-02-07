import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_auth_bloc/constant.dart';
import 'package:flutter_application_auth_bloc/cubit/auth_cubit.dart';
import 'package:flutter_application_auth_bloc/views/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
          onTap: () => Focus.of(context).unfocus(),
          child: Scaffold(
            body: BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) => _builderLoginView(),
              listener: (context, state) {
                if (state is AuthLoginError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)));
                }
                if (state is AuthLoginSuccess) {
                  formkey.currentState!.reset();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  Widget _builderLoginView() {
    return SafeArea(
        child: FormBuilder(
      key: formkey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Logo'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FormBuilderTextField(
                name: "Email",
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Enter email",
                  hintStyle: kHintStyle,
                  fillColor: Colors.grey,
                  filled: true,
                ),
              ),
            )
          ],
        ),
      )),
    ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Aplication'),
        content: const Text('Are you sure ?'),
        actions: [
          TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text(
                'Ýes',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black54),
              ))
        ],
      ),
    ));
  }
}

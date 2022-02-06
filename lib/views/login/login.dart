import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
          onTap: () => Focus.of(context).unfocus(),
          child: Scaffold(),
        ),
        onWillPop: _onWillPop);
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

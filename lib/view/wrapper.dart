import 'package:donation_box/view/auth-screen.dart';
import 'package:flutter/material.dart';

import '../home.dart';

import '../view-model/auth.dart';

class LoginWrapper extends StatefulWidget {
  const LoginWrapper({Key? key}) : super(key: key);
  static const route = '/';

  @override
  State<LoginWrapper> createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
            future: autoLogn(),
            builder: (
                BuildContext context,
                AsyncSnapshot<String> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  if(snapshot.data=="success") {
                    return Home();
                  } else {
                    return AuthScreen();
                  }

                } else {
                  return AuthScreen();
                }
              } else {
                return AuthScreen();
              }
            },),
      ),
    );
  }
}

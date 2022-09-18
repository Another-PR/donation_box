import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const route = '/';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  var _passwordController = TextEditingController();
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Build Called');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Signup'),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        //alignment: Alignment.center,
        child: Card(
          elevation: 20,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              width: size.width * 0.8,
              height: _authMode == AuthMode.Signup
                  ? size.height * 0.5
                  : size.height * 0.4,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                        }
                      },
                    ),
                    const Spacer(),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty || value.length < 6) {
                            return 'Password must be least 6 chars long';
                          }
                        }
                      },
                    ),
                    const Spacer(),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty || value.length < 6) {
                              return 'Password must be least 6 chars long';
                            }
                          }
                        },
                      ),
                    const Spacer(),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {},
                            child: Text(_authMode == AuthMode.Login
                                ? 'Login'
                                : 'Signup'),
                          ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        print(_authMode.toString());
                        _switchAuthMode();
                        print(_authMode.toString());
                      },
                      child: Text(_authMode == AuthMode.Login
                          ? "Don't have an account ? Signup here"
                          : "Already have an account ? Login here"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

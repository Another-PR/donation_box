import 'package:donation_box/main_menu.dart';
import 'package:donation_box/model/user.dart';
import 'package:donation_box/view-model/auth.dart';
import 'package:donation_box/view-model/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:donation_box/main.dart';

import 'package:intl/intl.dart';


enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);


  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
    'dob': ''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _dateInputController = TextEditingController();
  DateTime? pickedDate;
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

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      //invalid!
      print('Invalid');
      return;
    }

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      print('log in');
      var signInStatus =
          await loginUser(_authData['email'], _authData['password']);
      print('Sign In Status: ' + signInStatus.toString());
      if (signInStatus == 'success') {
        var user = LocalUser(_authData['email']!, _authData['password']!);
        localUser.write(() {
          localUser.add(user);
        });
        Get.offAndToNamed('/home');
      } else {
        Get.snackbar('Unable to Login', signInStatus,
            snackPosition: SnackPosition.BOTTOM);
      }
      //Log user in
    } else {
      print('Email' + _authData['email'].toString());
      print('pass' + _authData['password'].toString());
      var signUpStatus = await registerUser(_authData);
      print('SignUp Status: ' + signUpStatus.toString());
      if (signUpStatus == 'success') {
        var user = LocalUser(_authData['email']!, _authData['password']!);
        localUser.write(() {
          localUser.add(user);
        });
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Get.snackbar('Unable to Sign Up', signUpStatus,
            snackPosition: SnackPosition.BOTTOM);
      }
      //Sign up user
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: MainMenu(),
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
              padding: const EdgeInsets.all(20),
              width: size.width * 0.8,
              height: _authMode == AuthMode.Signup
                  ? size.height * 0.8
                  : size.height * 0.4,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    if (_authMode == AuthMode.Signup)
                      Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {

                                  return 'Please type in a valid Name';
                                }
                                _authData['name'] = value;

                              }
                            },
                            onSaved: (value) {
                              if (value!.isNotEmpty) {
                                _authData['name'] = value;
                              }
                            },
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _dateInputController,
                            decoration: const InputDecoration(
                              labelText: 'Enter DOB',
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                                size: 18,
                              ),
                              //iconColor: Colors.black,
                            ),
                            onTap: () async {
                              pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());
                              if (pickedDate != null) {
                                _dateInputController.text =
                                    DateFormat('dd-MM-yyyy')
                                        .format(pickedDate!);
                                print(pickedDate);
                                setState(() {});
                              }
                            },
                            validator: (value) {
                              if (value != null) {
                                bool isAge = pickedDate!.isAtleastYearsOld(18);
                                if (value.isEmpty || isAge == false) {
                                  return 'You need to be more than 18 to sign up';
                                }
                                _authData['dob'] = value;
                              }
                            },
                            onSaved: (value) {
                              if (value!.isNotEmpty) {
                                _authData['dob'] = value;
                              }
                            },
                          ),
                        ],
                      ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          _authData['email'] = value;
                        }
                      },
                      onSaved: (value) {
                        if (value!.isNotEmpty) {
                          _authData['email'] = value;
                        }
                      },
                    ),
                    const Spacer(),
                    TextFormField(
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty || value.length < 6) {
                            return 'Password must be least 6 chars long';
                          }
                        }
                      },
                      onSaved: (value) {
                        if (value!.isNotEmpty) {
                          _authData['password'] = value;
                        }
                      },
                    ),
                    const Spacer(),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          print(value.toString());
                          print(_passwordController.text);
                          if (value != null) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                          }
                        },
                      ),
                    const Spacer(),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              _submit();
                            },
                            child: Text(_authMode == AuthMode.Login
                                ? 'Login'
                                : 'Signup'),
                          ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        _switchAuthMode();
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

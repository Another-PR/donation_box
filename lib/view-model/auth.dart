import 'package:donation_box/main.dart';
import 'package:donation_box/view-model/mongo_connect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

import '../model/user.dart';

EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);

Future<String> registerUser(email, password) async {
  var msg = 'fail';
  try {
    await authProvider.registerUser(email, password).then((onValue) async {
      print('User Registered');
      Credentials emailPwCredentials =
          Credentials.emailPassword(email, password);
      try {
        await app.logIn(emailPwCredentials).then((value) async {
          print('Logged In');
          msg = 'success';
        });
      } on RealmException catch (e) {
        return e.message;
      }
    });
  } on RealmException catch (e) {
    return e.message;
  }
  return msg;
}

Future<String> autoLogn() async {
  if (uuser.all<LocalUser>().isEmpty) {
    return "NA";
  }
  var result = await loginUser(
      uuser.all<LocalUser>().first.email, uuser.all<LocalUser>().first.userPassword);
  return result;
}

Future<String> loginUser(email, password) async {
  var msg = 'fail';
  Credentials emailPwCredentials = Credentials.emailPassword(email, password);
  try {
    await app.logIn(emailPwCredentials).then((value) async {
      print('Logged In');
      msg = 'success';
    });
  } on RealmException catch (e) {
    return e.message;
  }
  return msg;
}

Future<String> logOutUser() async {
  var msg = 'fail';
  try {
    if (app.currentUser != null) {
      await app.currentUser!.logOut().then((value) {
        msg = 'success';
        print('Logged Out');
      });
    } else {
      throw 'something went wrong';
    }
  } on RealmException catch (e) {
    return e.message;
  } catch (e) {
    msg = e.toString();
    return e.toString();
  }
  return msg;
}

// Future<String>

//loginUser(email, password) {}

final registerUserProvider = FutureProvider((ref) => {});

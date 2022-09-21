import 'package:donation_box/view-model/mongo_connect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);

Future<String> registerUser(email, password) async {
  var msg = 'failure';
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

Future<String> loginUser(email, password) async {
  var msg = 'failure';
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

//loginUser(email, password) {}

final registerUserProvider = FutureProvider((ref) => {});

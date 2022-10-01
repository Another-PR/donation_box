import 'package:donation_box/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:realm/realm.dart';

import '../model/user.dart' as model;
import '../model/user.dart';
//Realm Code
AppConfiguration appConfig = AppConfiguration('donation-box-wrnah');
App app = App(appConfig);


//MongoDB Legacy
connectToDB() async {
  var db = await Db.create(dotenv.get('MONGO_URI'));
  await db
      .open()
      .then((value) => print("CONNECTED"))
      .catchError((onError) => print(onError));

  var users = uuser.all<LocalUser>();
  print("printing users from realm");
  // print(users.first.email);

}

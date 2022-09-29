import 'package:mongo_dart/mongo_dart.dart';
import 'package:realm/realm.dart';

import '../model/user.dart' as model;

//Realm Code
AppConfiguration appConfig = AppConfiguration('donation-box-wrnah');
App app = App(appConfig);

//MongoDB Legacy
connectToDB() async {
  var db = await Db.create(<uri_here>);
  await db
      .open()
      .then((value) => print("CONNECTED"))
      .catchError((onError) => print(onError));

  model.User test =
      model.User(userName: 'test', userId: '123456789', email: 'test@test.com');
  var userColl = db.collection('users');

  userColl.insert(test.toJson());
  print(await userColl.find().toList());
}

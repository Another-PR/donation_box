import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:realm/realm.dart';

import '../model/user.dart' as model;

//Realm Code
AppConfiguration appConfig = AppConfiguration('donation-box-wrnah');
App app = App(appConfig);

//MongoDB Legacy
connectToDB() async {
  //var db = await Db.create(
  //  "mongodb+srv://another_pr:OharBxvkPtZuifrm@cluster0.dlxsqx4.mongodb.net/?retryWrites=true&w=majority");
  var db = await Db.create(dotenv.get('MONGO_URI'));
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

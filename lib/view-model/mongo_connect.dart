import 'package:donation_box/model/globals.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:realm/realm.dart';

import '../model/user.dart' as model;

//Realm Code
AppConfiguration appConfig = AppConfiguration('donation-box-wrnah');
App app = App(appConfig);

late DbCollection userColl;
late Db db;

//MongoDB Legacy
connectToDB() async {
  db = await Db.create(dotenv.get('MONGO_URI'));
  await db.open().then((value) {
    IS_DB_CONNECTED = true;
    print('CONNECTED TO DB');
  }).catchError((error) {
    IS_DB_CONNECTED = false;
    print(error);
  });
}

//initialize collections
initializeCollections() async {
  try {
    userColl = await db.collection('users');
    print('USER COLLECTION INTIALISED');
  } catch (error) {
    print(error);
  } //users collection
}

//insert Data
void insertUser(model.User user) async {
  var userInColl =
      await userColl.find(where.eq('user_id', user.userId)).toList();
  if (userInColl.isEmpty) {
    await userColl.insert(user.toJson()).then((value) {
      print('Inserted user : ${user.userId}');
    });
  }
}

Future<model.User> getUser(userId) async {
  var userInColl = await userColl.find(where.eq('user_id', userId)).toList();
  if (userInColl.isNotEmpty) {
    model.User fetchedUser = model.User.fromJson(userInColl[0]);
    print(fetchedUser.userId);
    return fetchedUser;
  }
  throw Exception("Either user doesn't exist or something went wrong with db");
}

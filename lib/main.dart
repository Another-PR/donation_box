import 'package:donation_box/debug.dart';
import 'package:donation_box/home.dart';
import 'package:donation_box/model/user.dart';
import 'package:donation_box/view-model/mongo_connect.dart';
import 'package:donation_box/view/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:realm/realm.dart';

late Realm localUser;
void main() async {
  var config = Configuration.local(
    [LocalUser.schema],
  );
  localUser = Realm(config);
  await dotenv.load(fileName: ".env");
  await connectToDB();
  await initializeCollections();

  print(dotenv.get('MONGO_URI'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const Home(),
      initialRoute: '/', //TODO Error screen
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case LoginWrapper.route:
            return PageTransition(
                child: LoginWrapper(),
                type: PageTransitionType.leftToRight,
                settings: settings);
          case Home.route:
            return PageTransition(
                child: Home(),
                type: PageTransitionType.leftToRight,
                settings: settings);
          case Debug.route:
            return PageTransition(
                child: Debug(),
                type: PageTransitionType.leftToRight,
                settings: settings);
          default:
            return null;
        }
      },
    );
  }
}

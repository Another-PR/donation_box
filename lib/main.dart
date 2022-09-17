import 'package:donation_box/debug.dart';
import 'package:donation_box/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
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

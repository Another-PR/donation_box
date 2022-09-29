import 'package:donation_box/main_menu.dart';
import 'package:donation_box/view-model/mongo_connect.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  static const route = '/home';
  var name = app.currentUser?.profile;
  @override
  Widget build(BuildContext context) {
    print(name?.email.toString());
    //print(name?.);
    return Scaffold(
      endDrawer: MainMenu(),
      appBar: AppBar(
        title: const Text('Browse Boxes'),
      ),
      body: Center(
        child: Container(
          child: Text('Start point'),
        ),
      ),
    );
  }
}

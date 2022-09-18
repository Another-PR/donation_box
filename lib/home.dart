import 'package:donation_box/main_menu.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
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

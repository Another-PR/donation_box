import 'package:donation_box/main_menu.dart';
import 'package:flutter/material.dart';

class Debug extends StatelessWidget {
  const Debug({Key? key}) : super(key: key);
  static const route = '/debug';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainMenu(),
      appBar: AppBar(
        title: const Text('Browse Boxes'),
      ),
      body: Center(
        child: Container(
          child: Text('Debug here'),
        ),
      ),
    );
  }
}

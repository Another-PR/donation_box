import 'package:donation_box/debug.dart';
import 'package:donation_box/home.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ListView(
        children: [
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Home.route);
            },
          ),
          ListTile(
            title: Text('Debug'),
            onTap: () {
              Navigator.of(context).pushNamed(Debug.route);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:donation_box/debug.dart';
import 'package:donation_box/home.dart';
import 'package:donation_box/view-model/auth.dart';
import 'package:donation_box/view-model/mongo_connect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          ListTile(
            title: Text(app.currentUser != null ? 'LogOut' : 'Log in'),
            onTap: () async {
              if (app.currentUser != null) {
                print(app.currentUser!.profile.email);
                var x = await logOutUser();
                if (x == 'success') {
                  Get.offAndToNamed('/');
                } else {
                  Get.snackbar("Couldn't Log out", x,
                      snackPosition: SnackPosition.BOTTOM);
                }
              }
              //else null;
            },
          ),
        ],
      ),
    );
  }
}

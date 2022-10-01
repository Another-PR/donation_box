import 'package:donation_box/main_menu.dart';
import 'package:donation_box/view-model/mongo_connect.dart';
import 'package:flutter/material.dart';

class Debug extends StatefulWidget {
  const Debug({Key? key}) : super(key: key);
  static const route = '/debug';

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainMenu(),
      appBar: AppBar(
        title: const Text('Browse Boxes'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await getUser(app.currentUser!.id)
                            .then((value) => isLoading = false);
                        setState(() {});
                      },
                      child: const Text('get user'))
                ],
              ),
      ),
    );
  }
}

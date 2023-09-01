import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Profile/Profiel_image.dart';
import 'package:todo_app/files/Auth/Login.dart';

import 'Project_Add.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}
// bottomnavi

int index = 0;
List Pages = [const ImageLoad(), const Project_Add()];
//db
final _db = FirebaseDatabase.instance.ref('Sender');

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: w * 0.03),
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const LoginScreen())));
                                },
                                child: const Text('Yes')),
                          ],
                        );
                      });
                },
                icon: const Icon(CupertinoIcons.profile_circled)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: h * 0.05),
            Center(
              child: CircleAvatar(
                  radius: w * 0.15,
                  backgroundImage: const AssetImage('assets/images/bg.jpg')),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(left: h * 0.01),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'UserName',
                  style: TextStyle(
                      fontSize: h * 0.02, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.04,
              child: const Divider(
                color: Colors.black,
              ),
            ),
            NavigationBar(
                animationDuration: const Duration(seconds: 1),
                selectedIndex: index,
                onDestinationSelected: (value) {
                  setState(() {
                    index = value;
                  });
                },
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                backgroundColor: Colors.transparent,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.circle_grid_hex),
                      label: 'Post'),
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.add), label: 'Add Project'),
                ]),
            Pages[index]
          ],
        ),
      ),
    );
  }
}

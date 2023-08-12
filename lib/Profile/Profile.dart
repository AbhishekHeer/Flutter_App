import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Profile/Analysis.dart';
import 'package:todo_app/Profile/Tages.dart';

import 'Profiel_image.dart';
import '../files/Auth/Login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

int _index = 0;

List<Widget> _pages = [const ImageLoad(), const Analysis(), const Tag_page()];

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are You Sure'),
                          content: const Text('Logout ?'),
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
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                child: const Text('Yes')),
                          ],
                        );
                      });
                },
                icon: const Icon(CupertinoIcons.person_badge_minus_fill)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.05,
              width: w,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: w * 0.04),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: h * 0.2,
                      width: w * 0.9,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.black, Colors.blueAccent]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                              width: w * 0.3,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              child: CircleAvatar(
                                backgroundColor: Colors.brown,
                                radius: h * 0.1,
                                backgroundImage: const AssetImage(
                                  'assets/images/bg.jpg',
                                ),
                              )),
                          Container(
                            width: w * 0.6,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Follower',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Text(
                                        'following',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      InkWell(
                                        child: Text(
                                          'Post',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        '81',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: h * 0.02,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(
                                        width: w * 0.03,
                                      ),
                                      Text(
                                        '2',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: h * 0.02,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(
                                        width: w * 0.03,
                                      ),
                                      InkWell(
                                        child: Text(
                                          '31',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: h * 0.02,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            NavigationBar(
                animationDuration: const Duration(seconds: 1),
                selectedIndex: _index,
                onDestinationSelected: (value) {
                  setState(() {
                    _index = value;
                  });
                },
                backgroundColor: Colors.transparent,
                height: h * 0.07,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.circle_grid_hex),
                      label: 'Pics'),
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.chart_bar_square),
                      label: 'Pics'),
                  NavigationDestination(
                      icon: Icon(CupertinoIcons
                          .person_crop_circle_fill_badge_checkmark),
                      label: 'Pics'),
                ]),
            _pages[_index],
          ],
        ),
      ),
    );
  }
}

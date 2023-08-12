import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Pages/Camera.dart';
import 'package:todo_app/Pages/Instagram.dart';
import 'package:todo_app/Pages/Notes.dart';
import 'package:todo_app/Pages/Posts.dart';
import 'package:todo_app/Profile/Profile.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({super.key});

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

int current = 0;

List page = [
  const InstaCopy(),
  const Post(),
  const camera(),
  const Notes(),
  const Profile()
];

class _BottomNaviState extends State<BottomNavi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[current],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Color.fromARGB(255, 145, 110, 211),
        animationDuration: const Duration(seconds: 1),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: Color.fromARGB(61, 114, 216, 133),
        height: MediaQuery.of(context).size.height * 0.1,
        destinations: const [
          NavigationDestination(
              icon: Icon(CupertinoIcons.money_yen_circle_fill), label: "Gwant"),
          NavigationDestination(
              icon: Icon(CupertinoIcons.globe), label: "Posts"),
          NavigationDestination(
              icon: Icon(CupertinoIcons.camera), label: "Camera"),
          NavigationDestination(
              icon: Icon(CupertinoIcons.video_camera_solid), label: "Video"),
          NavigationDestination(
              icon: Icon(CupertinoIcons.profile_circled), label: "Profile"),
        ],
        onDestinationSelected: (int value) {
          setState(() {
            current = value;
          });
        },
        selectedIndex: current,
      ),
    );
  }
}

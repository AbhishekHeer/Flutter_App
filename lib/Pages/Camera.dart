import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Postscreen/Gallery.dart';
import 'package:todo_app/Postscreen/Post.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: AlignmentDirectional.bottomCenter,
              colors: [
            Colors.white10,
            Colors.black54,
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraPost()));
              },
              child: Container(
                height: h * 0.3,
                width: w * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 70, 178, 228),
                        Color.fromARGB(255, 0, 0, 0),
                      ]),
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.camera,
                    size: h * 0.03,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GalleryPost()));
              },
              child: Container(
                height: h * 0.3,
                width: w * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 70, 178, 228),
                        Color.fromARGB(255, 0, 0, 0),
                      ]),
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.folder_open,
                    size: h * 0.03,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

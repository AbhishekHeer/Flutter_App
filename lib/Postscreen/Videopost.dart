import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/Pages/Toast.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({super.key});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

final _controller = VideoPlayerController.file(Video!.absolute);

File? Video;
final _db = FirebaseStorage.instance;

final realtimeDB = FirebaseDatabase.instance.ref('Videos');
final id = DateTime.now().millisecondsSinceEpoch.toString();

class _VideoPostState extends State<VideoPost> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            ClipPath(
              clipper: videoClipper(),
              child: Container(
                color: const Color.fromARGB(255, 167, 126, 214),
                height: h * 0.56,
                child: Column(
                  children: [
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Upload Video',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: h * 0.03,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                          onTap: () async {
                            await _Videopick();
                            final upload = await _db
                                .ref('/Video/$id')
                                .putFile(Video!.absolute);
                            final url = await upload.ref.getDownloadURL();
                            realtimeDB
                                .child(id)
                                .set({'id': id, 'Video': url.toString()}).then(
                                    (value) {
                              Messege.toast('Added Successfully');
                            }).onError((error, stackTrace) =>
                                    Messege.toast(error.toString()));
                          },
                          child: Video == null
                              ? Lottie.asset(
                                  'assets/Amination/videoupload.json',
                                  repeat: true,
                                  reverse: true,
                                  width: w * 0.5,
                                  height: h * 0.4)
                              : VideoPlayer(_controller)),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: w * 0.25,
                left: w * 0.25,
                child: Container(
                  height: h * 0.08,
                  width: w * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.02),
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.cyan, Colors.purple]),
                  ),
                  child: Center(
                      child: Video == null
                          ? IconButton(
                              onPressed: () {
                                _Videopick();
                              },
                              icon: Icon(
                                CupertinoIcons.video_camera,
                                size: h * 0.05,
                              ))
                          : VideoPlayer(_controller)),
                )),
          ]),
          SizedBox(
            height: h * 0.1,
          ),
          Center(
            child: Text(
              'Your Video Is Secure ;)',
              style: TextStyle(
                fontSize: h * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: h * 0.01),
          const Center(
            child: Text('Uplaod Your Video In Firebase '),
          ),
        ],
      ),
    );
  }

  Future<void> _Videopick() async {
    final videopi = await ImagePicker().pickVideo(source: ImageSource.gallery);
    setState(() {
      if (videopi == null) {
        return;
      } else {
        Video = File(videopi.path);
      }
    });
  }
}

class videoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

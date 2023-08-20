import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(
          'Upload Video',
          style: TextStyle(fontSize: h * 0.03, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: h * 0.16,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  setState(() async {
                    _Videopick();
                    final upload =
                        await _db.ref('/Video/$id').putFile(Video!.absolute);
                    final url = await upload.ref.getDownloadURL();

                    realtimeDB
                        .child(id)
                        .set({'id': id, 'Video': url.toString()}).then((value) {
                      Messege.toast('added');
                    }).onError((error, stackTrace) {
                      Messege.toast(error.toString());
                    });
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 179, 96, 206),
                      borderRadius: BorderRadius.circular(h * 0.05),
                      border: Border.all(width: w * 0.006),
                    ),
                    width: w * 0.8,
                    height: h * 0.17,
                    child: Video == null
                        ? Icon(
                            CupertinoIcons.videocam,
                            size: h * 0.06,
                          )
                        : VideoPlayer(_controller)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _Videopick() async {
    final videopi = await FilePicker.platform.pickFiles(type: FileType.video);
    setState(() async {
      if (videopi == null) {
        return;
      } else {
        var finalurl = videopi.files.first as File?;

        Video = finalurl!.absolute;
      }
    });
  }
}

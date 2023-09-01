import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

final _db = FirebaseDatabase.instance.ref('Videos');

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h,
      width: w,
      child: SafeArea(
        child: Stack(
          children: [
            StreamBuilder(
                stream: _db.onValue,
                builder: ((context, snapshot) {
                  final sc = Videoplay(
                      snapshot.data!.snapshot.child('video').value.toString());
                  return ListView(
                    children: [
                      VideoPlayer(sc),
                    ],
                  );
                }))
          ],
        ),
      ),
    );
  }

  Videoplay(url) {
    final video = VideoPlayerController.networkUrl(Uri(path: url));
    video.play();
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Postscreen/Videopost.dart';
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
            FirebaseAnimatedList(
                query: _db,
                itemBuilder: ((context, snapshot, animation, index) {
                  VideoPlayerController sv =
                      Videoplay(snapshot.child('Video').value.toString());
                  return sv.value.hasError
                      ? const Icon(Icons.add)
                      : VideoPlayer(sv);
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

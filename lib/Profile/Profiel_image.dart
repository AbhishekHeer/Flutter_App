import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ImageLoad extends StatefulWidget {
  const ImageLoad({super.key});

  @override
  State<ImageLoad> createState() => _ImageLoadState();
}

final list = FirebaseDatabase.instance.ref('Sender');

// loading image

class _ImageLoadState extends State<ImageLoad> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h,
      width: w,
      child: Expanded(
        child: FirebaseAnimatedList(
            query: list,
            itemBuilder: ((context, snapshot, animation, index) {
              return ListTile(
                title: Image(
                  image: NetworkImage(snapshot.child('image').value.toString()),
                  fit: BoxFit.fill,
                  height: h * 0.09,
                  width: w * 0.09,
                ),
              );
            })),
      ),
    );
  }
}
  // FirebaseAnimatedList(
  //           query: list,
  //           itemBuilder: ((context, snapshot, animation, index) {
  //             return Center(
  //               child:
  //           })),
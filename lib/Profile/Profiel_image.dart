import 'package:firebase_database/firebase_database.dart';
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
          child: StreamBuilder(
              stream: list.onValue,
              builder: ((context, snapshot) {
                return GridView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: ((context, index) {
                      return GridTile(
                          child: Column(
                        children: [
                          Image(
                            image: NetworkImage(snapshot.data!.snapshot
                                .child('image')
                                .value
                                .toString()),
                            fit: BoxFit.fill,
                            height: h * 0.6,
                            width: w * 0.09,
                          ),
                          SizedBox(
                            width: w * 0.03,
                          )
                        ],
                      ));
                    }));
              })),
        ));
  }
}

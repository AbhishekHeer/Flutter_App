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
              builder: ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Text('Nothing Is Here');
                }
                return GridView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: ((context, index) {
                      return GridTile(
                          child: Column(
                        children: [
                          InkWell(
                            onHover: (value) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Image(
                                          image: NetworkImage(snapshot
                                              .data!.snapshot
                                              .child('image')
                                              .toString())),
                                    );
                                  });
                            },
                            child: Image(
                              image: NetworkImage(snapshot.data!.snapshot
                                  .child('image')
                                  .value
                                  .toString()),
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.fitHeight,
                              height: h * 0.9,
                              width: w * 0.09,
                            ),
                          ),
                        ],
                      ));
                    }));
              })),
        ));
  }
}

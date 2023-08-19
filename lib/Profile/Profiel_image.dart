import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ImageLoad extends StatefulWidget {
  const ImageLoad({super.key});

  @override
  State<ImageLoad> createState() => _ImageLoadState();
}

final list = FirebaseDatabase.instance.ref('Images');

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
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> liist = [];
                      liist.clear();
                      liist = map.values.toList();
                      return GridTile(
                          child: Column(
                        children: [
                          InkWell(
                            onHover: (value) {
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(h * 0.01),
                                    gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.black87,
                                          Colors.white70,
                                        ])),
                              );
                            },
                            child: Image(
                              image: NetworkImage(liist[index]['image']),
                              // filterQuality: FilterQuality.medium,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ],
                      ));
                    }));
              })),
        ));
  }
}

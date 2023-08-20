import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    return SingleChildScrollView(
      child: SizedBox(
          height: h,
          width: w,
          child: Expanded(
            child: StreamBuilder(
                stream: list.onValue,
                builder: ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Lottie.asset('assets/Amination/Loading.json',
                          fit: BoxFit.cover),
                    );
                  }
                  return GridView.builder(
                      itemCount: snapshot.data!.snapshot.children.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: ((context, index) {
                        Map<dynamic, dynamic> map =
                            snapshot.data!.snapshot.value as dynamic;
                        List<dynamic> liist = [];
                        liist.clear();
                        liist = map.values.toList();
                        return GridTile(
                            child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.02,
                            ),
                            InkWell(
                              child: SizedBox(
                                height: h * 0.2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image(
                                    image: NetworkImage(liist[index]['image']),
                                    fit: BoxFit.cover,
                                    height: h * 0.4,
                                    width: w * 0.88,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ));
                      }));
                })),
          )),
    );
  }
}

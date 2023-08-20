import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: ImagebackClipper(),
                child: Container(
                  height: h * 0.45,
                  width: w,
                  color: const Color.fromARGB(255, 167, 126, 214),
                  child: Center(
                      child: Lottie.asset('assets/Amination/ImageUpload.json')),
                ),
              ),
              Positioned(
                bottom: 0,
                left: w / 3.4,
                right: w / 3.4,
                child: Container(
                  height: h * 0.07,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.grey,
                            Color.fromARGB(255, 101, 166, 219),
                          ]),
                      borderRadius: BorderRadius.circular(h * 0.02)),
                  child: Center(
                      child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Center(child: Text('Upload')),
                              titleTextStyle: TextStyle(
                                  wordSpacing: h * 0.002,
                                  fontSize: h * 0.03,
                                  fontWeight: FontWeight.w600),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const CameraPost())));
                                      },
                                      icon: Icon(
                                        CupertinoIcons.camera,
                                        size: h * 0.05,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const GalleryPost())));
                                      },
                                      icon: Icon(
                                        CupertinoIcons.doc_chart,
                                        size: h * 0.04,
                                      )),
                                ],
                              ),
                              actions: [
                                Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel')))
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      CupertinoIcons.cloud_upload_fill,
                      size: h * 0.04,
                    ),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.27,
          ),
          Text(
            'Upload Your File',
            style: TextStyle(
                foreground: Paint(),
                fontSize: h * 0.03,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: h * 0.07,
          ),
          Text(
            'Browse The File You Want To Upload',
            style: TextStyle(
                foreground: Paint(),
                fontSize: h * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ImagebackClipper extends CustomClipper<Path> {
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
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

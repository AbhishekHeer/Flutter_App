import 'package:flutter/material.dart';

class ImageLoad extends StatefulWidget {
  const ImageLoad({super.key});

  @override
  State<ImageLoad> createState() => _ImageLoadState();
}

class _ImageLoadState extends State<ImageLoad> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h,
      width: w,
      child: Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 18,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: GridTile(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/bg.jpg',
                      fit: BoxFit.contain,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

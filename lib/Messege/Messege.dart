import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Messege/Chat.dart';

class Messege_for_chat extends StatefulWidget {
  const Messege_for_chat({super.key});

  @override
  State<Messege_for_chat> createState() => _Messege_for_chatState();
}

class _Messege_for_chatState extends State<Messege_for_chat> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    File? img;

    opencam() async {
      final imge = await ImagePicker().pickImage(source: ImageSource.camera);

      if (imge == null) {
        return;
      } else {
        setState(() {
          img = File(imge.path);
        });
      }
    }

    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Messege'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: h * 0.1,
              width: w,
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Image(
                          image: img == null
                              ? AssetImage('assets/images/bg.jpg')
                              : AssetImage(img.toString()))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: h,
              width: w,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (Context) => chat_page()));
                    },
                    title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                      child: const Text('User Name'),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.symmetric(horizontal: h * 0.02),
                      child: const Text('user ID'),
                    ),
                    leading: IconButton(
                        onPressed: () {
                          opencam();
                        },
                        icon: const Icon(
                          CupertinoIcons.camera_circle_fill,
                          size: 31,
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

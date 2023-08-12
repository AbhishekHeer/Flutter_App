import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class camera extends StatefulWidget {
  const camera({super.key});

  @override
  State<camera> createState() => _cameraState();
}

final messege = TextEditingController();

// file picker

File? _image;

imagepick() async {
  final img = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (img != null) {
    _image = File(img.path);
  }
}

// db

final _db = FirebaseFirestore.instance.collection('pdf');
final id = DateTime.now().microsecondsSinceEpoch.toString();

class _cameraState extends State<camera> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: h * 0.4,
                width: w,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/bg.jpg'),
                )),
            SizedBox(
              height: h * 0.1,
            ),
            ElevatedButton(
                onPressed: () async {
                  await imagepick();

                  await _db
                      .doc(id)
                      .set({'id': id, 'Messege': _image!.path.toString()});
                },
                child: const Text('Uplaod File')),
          ],
        ),
      ),
    );
  }
}

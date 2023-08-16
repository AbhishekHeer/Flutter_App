import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/Pages/BottomNavi.dart';
import 'package:todo_app/Pages/Toast.dart';

class GalleryPost extends StatefulWidget {
  const GalleryPost({super.key});

  @override
  State<GalleryPost> createState() => _PostScreenState();
}

final _db = FirebaseDatabase.instance.ref('Sender');
final Storage = FirebaseStorage.instance;
final caption = TextEditingController();
final id = DateTime.now().microsecondsSinceEpoch.toString();

class _PostScreenState extends State<GalleryPost> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: _gallery != null
                  ? ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.circular(h * 0.06),
                      child: Image.file(_gallery!.absolute),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => gallery(),
                          child: Container(
                            height: h * 0.3,
                            width: w * 0.4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 70, 178, 228),
                                    Color.fromARGB(255, 0, 0, 0),
                                  ]),
                            ),
                            child: Center(
                              child: _gallery != null
                                  ? Image.network(_gallery!.path)
                                  : Icon(
                                      CupertinoIcons.folder_open,
                                      size: h * 0.03,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: h * 0.01),
              child: TextField(
                controller: caption,
                decoration: InputDecoration(
                    suffix: const Icon(CupertinoIcons.forward),
                    hintText: 'Write Your Caption',
                    hintMaxLines: 4,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.centerRight,
                colors: [
              Colors.black26,
              Color.fromARGB(121, 98, 166, 171),
              Colors.cyanAccent
            ])),
        height: h * 0.1,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStatePropertyAll(Size.square(h * 0.07))),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: const Text(
                                'If You Click Delete Than It Will Not Posted In Your Account'),
                            title: const Text('Are You Sure ??'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const BottomNavi())));
                                  },
                                  child: const Text('Delete')),
                            ],
                          );
                        });
                  },
                  child: const Text('Delete')),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStatePropertyAll(Size.square(h * 0.07))),
                  onPressed: () async {
                    var path = Storage.ref()
                        .child('/images/$id')
                        .putFile(_gallery!.absolute);
                    var download = await path.snapshot.ref.getDownloadURL();

                    _db.child(id).set({
                      'id': id,
                      'caption': caption.text.toString(),
                      'image': download.toString()
                    }).then((value) {
                      Messege.toast('added Successfully');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavi()));
                    }).onError((error, stackTrace) {
                      Messege.toast(error.toString());
                    });
                  },
                  child: const Text('   Post   '))
            ],
          ),
        ),
      ),
    );
  }

  File? _gallery;
  Future<void> gallery() async {
    final opencam = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);

    setState(() {
      if (opencam != null) {
        _gallery = File(opencam.path);
      }
    });
  }
}

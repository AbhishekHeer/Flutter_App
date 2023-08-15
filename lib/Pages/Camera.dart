import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as f_s;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/Pages/Toast.dart';

class camera extends StatefulWidget {
  const camera({super.key});

  @override
  State<camera> createState() => _cameraState();
}

final messege = TextEditingController();

final _fs = f_s.FirebaseStorage.instance;
final _ref = FirebaseDatabase.instance.ref('Sender');

//cropper

Future<CroppedFile?> _crop() async {
  var cropimage = await ImageCropper().cropImage(
    sourcePath: _image!.path,
    aspectRatioPresets: Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
  );

  return cropimage;
}

// file picker

File? _image;

final id = DateTime.now().microsecondsSinceEpoch.toString();

@override
// db

class _cameraState extends State<camera> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: h * 0.4,
                width: w,
                child: _image != null
                    ? Image(image: FileImage(_image!))
                    : const Image(image: AssetImage('assets/images/bg.jpg'))),
            SizedBox(
              height: h * 0.1,
            ),
            ElevatedButton(
                onPressed: () async {
                  await imagepick();

                  f_s.Reference store =
                      f_s.FirebaseStorage.instance.ref('/images/$id');
                  f_s.UploadTask upload = store.putFile(_image!.absolute);

                  await Future.value(upload).then((value) async {
                    final url = await store.getDownloadURL();

                    _ref
                        .child(id)
                        .set({'id': id, 'image': url.toString()}).then((value) {
                      Messege.toast("Added Successfull");
                    }).onError((error, stackTrace) {
                      Messege.toast(error.toString());
                    });
                  }).onError((error, stackTrace) {
                    Messege.toast(error.toString());
                  });
                },
                child: const Text('Uplaod File')),
          ],
        ),
      ),
    );
  }

  //image form gallery

  Future<void> imagepick() async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);

    setState(() {
      if (img != null) {
        _image = File(img.path);
      }
    });
  }
}

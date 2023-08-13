import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class chat_page extends StatefulWidget {
  const chat_page({super.key});

  @override
  State<chat_page> createState() => _chat_pageState();
}

final messege = TextEditingController();

// file picker

PlatformFile? file;

Future<void> getfile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, allowedExtensions: ['pdf', 'jpg', 'jpeg']);

  if (result != null) file = result.files.first;
}

// db

final _db = FirebaseFirestore.instance.collection('pdf');
final id = DateTime.now().microsecondsSinceEpoch.toString();

class _chat_pageState extends State<chat_page> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;

    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Messege With Friend'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: h * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Sender extends StatefulWidget {
  const Sender({super.key});

  @override
  State<Sender> createState() => _SenderState();
}

final UserText = TextEditingController();

//db

final String Id = DateTime.now().microsecondsSinceEpoch.toString();

final _db = FirebaseDatabase.instance.ref('Sender');

class _SenderState extends State<Sender> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
              hintText: "Enter",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              suffix: IconButton(
                onPressed: () async {
                  await _db.child(Id).set({
                    'id': Id,
                    'Messege': UserText.text.toString(),
                  });
                  UserText.clear();
                },
                icon: Icon(Icons.send_rounded),
              )),
          controller: UserText,
        ),
      ),
    );
  }
}

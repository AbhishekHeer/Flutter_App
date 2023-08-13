import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class ImageLoad extends StatefulWidget {
  const ImageLoad({super.key});

  @override
  State<ImageLoad> createState() => _ImageLoadState();
}

final _db = FirebaseFirestore.instance.collection('pdf');

class _ImageLoadState extends State<ImageLoad> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return FirestoreListView(
        query: _db,
        itemBuilder: ((context, doc) {
          return Expanded(
            child: GridTile(
              child: Image.network(doc.id.toString()),
            ),
          );
        }));
  }
}

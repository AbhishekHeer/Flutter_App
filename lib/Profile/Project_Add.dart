import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Project_Add extends StatefulWidget {
  const Project_Add({super.key});

  @override
  State<Project_Add> createState() => _Project_AddState();
}

final Link = TextEditingController();

//db

final _db = FirebaseDatabase.instance.ref('Project-Links');
final id = DateTime.now().microsecondsSinceEpoch.toString();

class _Project_AddState extends State<Project_Add> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: h / 4,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: h / 3,
                          width: w,
                          child: Column(
                            children: [
                              SizedBox(
                                height: h * 0.1,
                                child: const Text('Paste Link Here'),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(w * 0.08),
                                  child: TextField(
                                    controller: Link,
                                    decoration: InputDecoration(
                                        suffix: IconButton(
                                          onPressed: () {
                                            _db.child('link').child(id).set({
                                              'id': id,
                                              'link': Link.text.toString()
                                            });
                                          },
                                          icon: const Icon(
                                              CupertinoIcons.forward),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                w * 0.05))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                  // _db.child(id).set({

                  // })
                },
                child: const Text('Add Project')),
          )
        ],
      ),
    );
  }
}

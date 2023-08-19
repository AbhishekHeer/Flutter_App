import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Profile/Profile.dart';

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
          Expanded(
            child: SizedBox(
              height: h / 4,
            ),
          ),
          StreamBuilder(
              stream: _db.onValue,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.data!.snapshot.exists) {
                  return ElevatedButton(
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
                                                  _db.child(id).set({
                                                    'id': id,
                                                    'link': Link.text.toString()
                                                  });
                                                  Link.clear();
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                    CupertinoIcons.forward),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          w * 0.05))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      style: ButtonStyle(
                          maximumSize: MaterialStatePropertyAll(
                              Size.fromRadius(h * 0.1))),
                      child: const Text('Add Project'));
                } else {
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> liiist = [];
                  liiist.clear();
                  liiist = map.values.toList();
                  return ListView.builder(
                      itemCount: snapshot.data!.snapshot.children.length,
                      itemBuilder: (context, index) {
                        return Scaffold(
                          body: Card(
                            child: ListTile(
                              title: Text(liiist[index]['link']),
                              trailing: IconButton(
                                  onPressed: () {
                                    _db.child('link').remove();
                                  },
                                  icon: const Icon(CupertinoIcons.delete)),
                            ),
                          ),
                          floatingActionButton: FloatingActionButton(
                            onPressed: () {},
                            child: const Icon(CupertinoIcons.add),
                          ),
                        );
                      });
                }
              }))
        ],
      ),
    );
  }
}

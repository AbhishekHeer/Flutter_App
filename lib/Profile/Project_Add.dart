import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Pages/Toast.dart';

class Project_Add extends StatefulWidget {
  const Project_Add({super.key});

  @override
  State<Project_Add> createState() => _Project_AddState();
}

final DatabaseReference _db = FirebaseDatabase.instance.ref('Project-Links');
final Link = TextEditingController();
final Link_upade = TextEditingController();
final ProjectName = TextEditingController();
final ProjectName_update = TextEditingController();
final id = DateTime.now().microsecondsSinceEpoch.toString();

class _Project_AddState extends State<Project_Add> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: h * 0.5,
          width: w,
          child: StreamBuilder(
              stream: _db.onValue,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> items = [];
                  items.clear();
                  items = map.values.toList();
                  return ListView.builder(
                      itemCount: snapshot.data!.snapshot.children.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(items[index]),
                          trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Update'),
                                                  content: SizedBox(
                                                    height: h * 0.2,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      w * 0.03),
                                                          child: TextField(
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    'Project',
                                                                label: const Text(
                                                                    'Project Name'),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(h *
                                                                            0.02))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      w * 0.03),
                                                          child: TextField(
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    'Link',
                                                                label: const Text(
                                                                    'Project Link'),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(h *
                                                                            0.02))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('No')),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          _db.update({
                                                            'Porject-Name':
                                                                ProjectName_update
                                                                    .text
                                                                    .toString(),
                                                            'link': Link_upade
                                                                .text
                                                                .toString()
                                                          }).then((value) {
                                                            Messege.toast(
                                                                'Added Successfully');
                                                            Link_upade.clear();
                                                            ProjectName_update
                                                                .clear();
                                                            Navigator.pop(
                                                                context);
                                                          }).onError((error,
                                                              stackTrace) {
                                                            Messege.toast(error
                                                                .toString());
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Update')),
                                                  ],
                                                );
                                              });
                                        },
                                        title: const Text('Update'),
                                        leading: const Icon(CupertinoIcons
                                            .pencil_ellipsis_rectangle),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            _db.remove();
                                          });
                                        },
                                        title: const Text('Delete'),
                                        leading:
                                            const Icon(CupertinoIcons.delete),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      child: ListTile(
                                        title: Text('data'),
                                        leading: Icon(CupertinoIcons.delete),
                                      ),
                                    ),
                                  ]),
                        );
                      });
                }
              })),
        ),
        IconButton(
            onPressed: () {
              showBottomSheet(
                  context: context,
                  builder: ((context) {
                    return SizedBox(
                      height: h * 0.6,
                      width: w,
                      child: Column(
                        children: [
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            'Enter Your Link .',
                            style: TextStyle(
                                fontSize: h * 0.03,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: h * 0.08,
                            width: w,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                            child: TextField(
                              controller: ProjectName,
                              decoration: InputDecoration(
                                hintText: 'Project Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(h * 0.01),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.05, vertical: h * 0.04),
                            child: TextField(
                              controller: Link,
                              decoration: InputDecoration(
                                  suffix: IconButton(
                                      onPressed: () {
                                        _db.child(id).set({
                                          'id': id,
                                          'Porject-Name':
                                              ProjectName.text.toString(),
                                          'link': Link.text.toString()
                                        }).then((value) {
                                          Messege.toast('Added Successfully');
                                          Link.clear();
                                          ProjectName.clear();
                                          Navigator.pop(context);
                                        }).onError((error, stackTrace) {
                                          Messege.toast(error.toString());
                                        });
                                      },
                                      icon: const Icon(
                                          CupertinoIcons.arrow_right_circle)),
                                  hintText: 'Paste Your Link',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(h * 0.01))),
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
            },
            icon: const Icon(CupertinoIcons.add))
      ],
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Messege/Messege.dart';
import 'package:todo_app/Pages/Toast.dart';

class InstaCopy extends StatefulWidget {
  const InstaCopy({super.key});

  @override
  State<InstaCopy> createState() => _InstaCopyState();
}

bool click = false;
bool bclick = false;

final list = FirebaseDatabase.instance.ref('Sender');

class _InstaCopyState extends State<InstaCopy> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 199, 199),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.transparent,
        title: const Text('You Want ? '),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Messege_for_chat()));
                },
                icon: const Icon(
                  CupertinoIcons.person_2,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.9,
              width: w,
              child: StreamBuilder(
                  stream: list.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    final item = snapshot.data!.snapshot;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text('wait Data Is Loading'),
                      );
                    }

                    return GridView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1),
                        itemBuilder: (context, index) {
                          return GridTile(
                            header: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.02, vertical: h * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  const Text('userName')
                                ],
                              ),
                            ),

                            // footer
                            footer: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            click = true;
                                          });

                                          Messege.Snack("Thanks For Like");
                                        },
                                        icon: click
                                            ? const Icon(
                                                CupertinoIcons.heart_fill,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                CupertinoIcons.heart,
                                                color: Colors.black,
                                              ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            isDismissible: false,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      w * 0.2),
                                            ),
                                            backgroundColor: Colors.black,
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  w * 0.02),
                                                          child: Text(
                                                            'Comments',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  h * 0.02,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                                CupertinoIcons
                                                                    .xmark_seal)),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.chat_bubble,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        CupertinoIcons.chevron_forward,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          bclick = true;
                                        });
                                      },
                                      icon: bclick
                                          ? const Icon(
                                              CupertinoIcons.bookmark_fill,
                                              color: Colors.black,
                                            )
                                          : const Icon(
                                              CupertinoIcons.bookmark,
                                              color: Colors.black,
                                            ),
                                    ),

                                    // text
                                  ],
                                ),
                                Text(snapshot.data!.snapshot
                                    .child('id')
                                    .value
                                    .toString()),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image: NetworkImage(
                                    item.child('image').value.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

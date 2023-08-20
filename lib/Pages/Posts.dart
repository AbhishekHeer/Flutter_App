import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

final _db = FirebaseDatabase.instance.ref('Sender');

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h,
              width: w,
              child: Expanded(
                  child: StreamBuilder(
                      stream: _db.onValue,
                      builder:
                          ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Lottie.asset(
                              'assets/Amination/Loading.json',
                              fit: BoxFit.cover,
                              repeat: true,
                              reverse: true,
                              animate: true,
                            ),
                          );
                        } else {
                          Map<dynamic, dynamic> map =
                              snapshot.data!.snapshot.value as dynamic;
                          List<dynamic> lissst = [];
                          lissst.clear();
                          lissst = map.values.toList();
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            itemCount: snapshot.data!.snapshot.children.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GridTile(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.black38,
                                          Colors.white38,
                                        ]),
                                  ),
                                  child: Text(lissst[index]['id']),
                                ),
                              );
                            },
                          );
                        }
                      }))),
            )
          ],
        ),
      ),
    );
  }
}

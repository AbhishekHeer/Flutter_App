import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/Messege/Messege.dart';

class InstaCopy extends StatefulWidget {
  const InstaCopy({super.key});

  @override
  State<InstaCopy> createState() => InstaCopyState();
}

bool click = false;
bool bclick = false;

final list = FirebaseDatabase.instance.ref('Images');

class InstaCopyState extends State<InstaCopy> {
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
        child: SizedBox(
          height: h * 0.8,
          width: w,
          child: StreamBuilder(
              stream: list.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Lottie.asset('assets/Amination/Loading.json'));
                }
                return GridView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1),
                    itemBuilder: (context, index) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> liist = [];
                      liist.clear();
                      liist = map.values.toList();

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: h * 0.04, top: h * 0.02),
                            child: Container(
                              height: h * 0.3,
                              width: w * 0.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(h * 0.06),
                                  gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.black38,
                                        Color.fromARGB(96, 198, 211, 178),
                                      ])),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(h * 0.02),
                                child: Image(
                                  image: NetworkImage(liist[index]['image']),
                                  fit: BoxFit.cover,
                                  height: h * 0.4,
                                  width: w * 0.88,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: h * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(CupertinoIcons.heart)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(CupertinoIcons
                                            .bubble_left_bubble_right_fill)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            CupertinoIcons.right_chevron)),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.bookmark)),
                              ],
                            ),
                          )
                        ],
                      );
                    });
              }),
        ),
      ),
    );
  }
}

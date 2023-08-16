import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Messege/Messege.dart';

class InstaCopy extends StatefulWidget {
  const InstaCopy({super.key});

  @override
  State<InstaCopy> createState() => InstaCopyState();
}

bool click = false;
bool bclick = false;

Uint8List? imagebytes;

final list = FirebaseDatabase.instance.ref('Sender');

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
          height: h * 0.79,
          width: w,
          child: StreamBuilder(
              stream: list.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
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
                      final fetchimage = snapshot.data!.snapshot
                          .child('image')
                          .value
                          .toString();

                      return Column(
                        children: [
                          Image(image: NetworkImage(fetchimage[index]))
                        ],
                      );
                    });
              }),
        ),
      ),
    );
  }

  imagefile(String path) async {
    var image = await rootBundle.load(path);
    return image;
  }
}

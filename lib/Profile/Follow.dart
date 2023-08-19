import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Follow extends StatefulWidget {
  const Follow({super.key});

  @override
  State<Follow> createState() => _FollowState();
}

final _db = FirebaseDatabase.instance.ref("Project-Links");

class _FollowState extends State<Follow> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h,
      width: w,
      child: StreamBuilder<DatabaseEvent>(
          stream: _db.onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.snapshot.children.length,
                itemBuilder: ((context, index) {
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> liist = [];
                  liist.clear();
                  liist = map.values.toList();

                  return Card(
                      child: ListTile(title: Text(liist[index]['link'])));
                }));
          }),
    );
  }
}

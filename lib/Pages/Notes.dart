import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/files/Auth/Login.dart';

import 'FullviewScreen.dart';
import 'Sender.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final UserText = TextEditingController();
  final Edit = TextEditingController();
  final Search = TextEditingController();

  final ref = FirebaseDatabase.instance.ref('Sender');
  final String Id = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(Icons.logout_outlined)),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: Search,
              decoration: InputDecoration(
                  hintText: 'Search Here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: ((context, snapshot, animation, index) {
                  final title = snapshot.child('Messege').value.toString();
                  final id = snapshot.child('id').value.toString();

                  if (title.isEmpty) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Hero(
                            tag: 'ListAai1',
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TextView(
                                              Note: title,
                                              ID: id,
                                            )));
                              },
                              title: Text(
                                  snapshot.child('Messege').value.toString()),
                              trailing: IconButton(
                                  onPressed: () {
                                    ref.child(id).remove();
                                  },
                                  icon: Icon(Icons.delete_outline_outlined)),
                              leading: IconButton(
                                  onPressed: () {
                                    _showAlertDialog(title, id);
                                  },
                                  icon: Icon(Icons.edit_document)),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .contains(Search.text.toLowerCase())) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Hero(
                            tag: 'ListAai',
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TextView(
                                              Note: title,
                                              ID: id,
                                            )));
                              },
                              title: Text(
                                  snapshot.child('Messege').value.toString()),
                              trailing: IconButton(
                                  onPressed: () {
                                    ref.child(id).remove();
                                  },
                                  icon: const Icon(
                                      Icons.delete_outline_outlined)),
                              leading: IconButton(
                                  onPressed: () {
                                    _showAlertDialog(title, id);
                                  },
                                  icon: Icon(Icons.edit)),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                })),
          ),
          Sender(),
        ],
      ),
    );
  }

  Future<void> _showAlertDialog(String Title, String ID) async {
    Edit.text = Title;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Edit Note'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure You want to Edit ?'),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: Edit,
                  decoration: InputDecoration(
                    hintText: 'Enter Your notes',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Edit'),
              onPressed: () {
                ref
                    .update({'Messege': Edit.text.toString()})
                    .then((value) {})
                    .onError((error, stackTrace) {});
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

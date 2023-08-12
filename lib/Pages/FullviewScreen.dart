// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  final String Note;
  final String ID;
  const TextView({
    Key? key,
    required this.Note,
    required this.ID,
  }) : super(key: key);

  @override
  State<TextView> createState() => _TextViewState();
}

final Edit = TextEditingController();

//db FB

final ref = FirebaseDatabase.instance.ref('Sender');

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Hero(
                tag: 'ListAai1',
                child: Text(
                  widget.Note,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _showAlertDialog(widget.Note, widget.ID);
                      });
                    },
                    child: Text('Edit')),
                TextButton(onPressed: () {}, child: Text('Save')),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.redAccent),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {},
                    child: Text('Delete')),
              ],
            )
          ],
        ),
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
                Text('Are you sure want to Edit'),
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
                    .child(ID)
                    .update({'Messege': Edit.text.toString()}).then((value) {
                  print('done');
                }).onError((error, stackTrace) {
                  print(error.toString());
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/UserDetails/OTPScreen.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

@override
void initState() {
  _EP.text = '';
}

TextEditingController _EP = TextEditingController();
final _dateofbirth = TextEditingController();

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Name And Email'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.1,
              width: w,
              child: Center(
                  child: Text(
                'Email Or Number',
                style: GoogleFonts.yesevaOne(fontSize: h * 0.025),
              )),
            ),
            Padding(
              padding: EdgeInsets.all(h * 0.04),
              child: TextField(
                controller: _EP,
                decoration: InputDecoration(
                    label: const Center(child: Text('Email Or Number')),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(h * 0.02))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(h * 0.04),
              child: TextField(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (date != null) {
                    String format = DateFormat('dd-MM-yyyy').format(date);

                    _dateofbirth.text = format;
                  }
                },
                controller: _dateofbirth,
                readOnly: true,
                decoration: InputDecoration(
                    label: const Text('Email Or Number'),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(h * 0.02))),
              ),
            ),
            ElevatedButton(
              child: const Icon(CupertinoIcons.arrow_right),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OTPScreen()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

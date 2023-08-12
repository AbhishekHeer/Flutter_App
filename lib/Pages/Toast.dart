import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Messege {
  static toast(String Mess) {
    Fluttertoast.showToast(
        msg: Mess,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Snack(String mess) {
    SnackBar(
      content: Text(mess),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
  }
}

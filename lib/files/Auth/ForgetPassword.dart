import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Pages/Toast.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

final forget = TextEditingController();

//db

final Auth = FirebaseAuth.instance;

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: TextField(
              controller: forget,
              decoration: InputDecoration(
                  hintText: 'Enter Email',
                  label: const Text('Email'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          OutlinedButton(
              onPressed: () {
                Auth.sendPasswordResetEmail(email: forget.text.toString())
                    .then((value) {
                  Messege.toast('Checl Your Email For Reset Password');
                }).onError((error, stackTrace) {
                  Messege.toast(error.toString());
                });
              },
              child: const Text('Forget'))
        ],
      ),
    );
  }
}

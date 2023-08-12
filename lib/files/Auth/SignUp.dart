import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/files/Auth/Login.dart';

import '../../Pages/Notes.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final _db = FirebaseAuth.instance;

final _email = TextEditingController();
final _pass = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: h * 0.3,
                width: w,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      label: const Text('Enter Your Email'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextField(
                  controller: _pass,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      label: const Text('Enter Your password'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Again',
                      label: const Text('Comfirm Your Password'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
              SizedBox(
                height: h * 0.1,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.square(50),
                  ),
                  onPressed: () {
                    createUser();
                  },
                  child: Text('Sign-Up')),
              SizedBox(
                height: h * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Have An Account',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child:
                          const Text('Login', style: TextStyle(fontSize: 20)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  createUser() {
    _db
        .createUserWithEmailAndPassword(
            email: _email.text.toString(), password: _pass.text.toString())
        .then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Notes()));
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}

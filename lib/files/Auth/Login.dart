import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/Pages/BottomNavi.dart';
import 'package:todo_app/files/Auth/ForgetPassword.dart';
import 'package:todo_app/files/Auth/SignUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _db = FirebaseAuth.instance;

// controller

final _email = TextEditingController();
final _pass = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
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
                  child: Center(
                      child: Lottie.asset('assets/Amination/login.json'))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      label: const Text('Email'),
                      hintText: 'Enter Your Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(
                height: h * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _pass,
                  decoration: InputDecoration(
                      label: const Text('password'),
                      hintText: 'Enter Your password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: const Text(
                      'Forget Password',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.square(50),
                  ),
                  onPressed: () async {
                    if (_email.text.isEmpty || _pass.text.isEmpty) {
                      return;
                    } else {
                      await getData();
                      _email.clear();
                      _pass.clear();
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont't Have An Account",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child:
                          const Text('Sign-Up', style: TextStyle(fontSize: 20)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getData() async {
    await _db
        .signInWithEmailAndPassword(
            email: _email.text.toString(), password: _pass.text.toString())
        .then((value) {
      Fluttertoast.showToast(
          msg: "Enter To App",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomNavi()));
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

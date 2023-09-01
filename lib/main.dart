import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Pages/BottomNavi.dart';
import 'package:todo_app/Provider/Like.dart';
import 'package:todo_app/UserDetails/details.dart';
import 'package:todo_app/files/Auth/Login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Like()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
          shape: const MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          side: MaterialStatePropertyAll(BorderSide(
              style: BorderStyle.solid,
              color: Colors.black,
              width: w * 0.0004)),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: h * 0.03, vertical: h * 0.02),
          ),
          minimumSize: MaterialStatePropertyAll(Size.square(h * 0.04)),
          foregroundColor: const MaterialStatePropertyAll(
            Colors.black,
          ),
          backgroundColor: const MaterialStatePropertyAll(
              Color.fromARGB(151, 184, 174, 174)),
        ))),
        debugShowCheckedModeBanner: false,
        home: const Details(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

final _db = FirebaseAuth.instance;

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (_db.currentUser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavi()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/Amination/splash1.json',
          repeat: true, reverse: true, fit: BoxFit.contain),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/Pages/BottomNavi.dart';
import 'package:todo_app/Pages/Camera.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.transparent),
          iconTheme: IconThemeData(color: Colors.black),
          scaffoldBackgroundColor: Color.fromARGB(252, 190, 213, 208),
          iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
                  iconColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 0, 0, 0)))),
          navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Color.fromARGB(255, 116, 163, 163),
              indicatorColor: Color.fromARGB(255, 0, 0, 0)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Splash());
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
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 15), () {
      if (_db.currentUser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavi()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/Amination/splash1.json',
          repeat: true, reverse: true, fit: BoxFit.cover),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Pages/BottomNavi.dart';
import 'package:todo_app/Provider/Like.dart';
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
    return MaterialApp(
      // themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        scaffoldBackgroundColor: const Color.fromARGB(251, 212, 218, 217),
        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
                iconColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 0, 0, 0)))),
        navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            indicatorColor: Color.fromARGB(255, 255, 255, 255)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 153, 150, 158)),
        useMaterial3: true,
      ),
      home: Provider(create: (_) => Like(), child: const BottomNavi()),
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

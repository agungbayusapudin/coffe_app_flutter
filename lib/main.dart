import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseweb/auth/login_pages.dart';
import 'package:firebaseweb/dasboard/dashboard_pages.dart';
import 'package:firebaseweb/firebase_options.dart';
import 'package:firebaseweb/intro/intro_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 235, 233, 233)),
        useMaterial3: true,
      ),
      home: const LoginPages(),
    );
  }
}

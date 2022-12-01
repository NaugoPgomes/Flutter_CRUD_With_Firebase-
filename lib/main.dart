import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Home.dart';
import 'Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: (FirebaseAuth.instance.currentUser == null ) ? Login(): Home(),
    );
  }
}
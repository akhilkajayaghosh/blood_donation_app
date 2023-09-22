import 'package:flutter/material.dart';
import './project/home.dart';
import '/project/add.dart';
import '/project/update.dart';
import 'project/view.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo App",
      color: Colors.lime,
      //home: Home(),
      routes: {
        '/': (context) => Home(),
        '/add': (context) => AddUser(),
        '/update':(context) => UpdateUser(),
        '/view':(context) => View(),
      },
      initialRoute: '/',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final CollectionReference donar =
      FirebaseFirestore.instance.collection('donar');
  void deleteDonar(docId) {
    donar.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 227, 231, 232),
        child: ListView(
          
          children: [
            ListTile(
              leading: Icon(Icons.home),
              iconColor: Color.fromARGB(255, 160, 2, 2),
              title: Text(
                "Home",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 160, 2, 2)),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.new_label),
              iconColor: Color.fromARGB(255, 160, 2, 2),
              title: Text(
                "Donar Registration",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 160, 2, 2)),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/add');
              },
            ),
            ListTile(
              leading: Icon(Icons.view_agenda),
              iconColor: Color.fromARGB(255, 160, 2, 2),
              title: Text(
                "View Donars",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 160, 2, 2)),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/view');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Blood Donation App"),
        leading: IconButton(
            onPressed: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu)),
        backgroundColor: Color.fromARGB(255, 206, 14, 14),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/blood2.jpg"), fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Color.fromARGB(255, 166, 68, 12),
        label:Text("Donate Blood",style: TextStyle(fontSize: 22),),
        icon: Icon(Icons.add),
      ),
    );
  }
}

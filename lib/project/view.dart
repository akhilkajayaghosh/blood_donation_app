import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  final CollectionReference donar =
      FirebaseFirestore.instance.collection('donar');
  void deleteDonar(docId) {
    donar.doc(docId).delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Registered Donars"),
        backgroundColor: Color.fromARGB(255, 206, 14, 14),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: StreamBuilder(
          stream: donar.orderBy('Name').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot donarSnap = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 136, 164, 201),
                          blurRadius: 10,
                        )
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Text(
                                donarSnap['Group'].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(donarSnap['Name'],
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                              Text(
                                donarSnap['Phone'].toString(),
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: {
                                        'Name': donarSnap['Name'],
                                        'Phone': donarSnap['Phone'].toString(),
                                        'Group': donarSnap['Group'],
                                        'id': donarSnap.id
                                      });
                                },
                                icon: Icon(Icons.edit),
                                iconSize: 30,
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteDonar(donarSnap.id);
                                },
                                icon: Icon(Icons.delete),
                                iconSize: 30,
                                color: Colors.red,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }
}

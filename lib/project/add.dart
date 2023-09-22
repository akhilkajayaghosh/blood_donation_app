import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddUser> {
  final bloodgrps = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedGroup;
  final CollectionReference donar =
      FirebaseFirestore.instance.collection('donar');
  TextEditingController donarName = TextEditingController();
  TextEditingController donarPhone = TextEditingController();
  void addDonar() {
    final data = {
      'Name': donarName.text,
      'Phone': donarPhone.text,
      'Group': selectedGroup
    };
    donar.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Donars"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: donarName,
              decoration: InputDecoration(
                  label: Text(
                    "Donar Name",
                  ),
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: donarPhone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Phone Number"),
              ),
              maxLength: 10,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButtonFormField(
                decoration:
                    InputDecoration(label: Text("Select your Blood Group")),
                items: bloodgrps
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedGroup = val;
                }),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              onPressed: () {
                addDonar();
                Navigator.pop(context);
              },
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}

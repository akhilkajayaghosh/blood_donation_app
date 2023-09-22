import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<UpdateUser> {
  final bloodgrps = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedGroup;
  final CollectionReference donar =
      FirebaseFirestore.instance.collection('donar');
  TextEditingController donarName = TextEditingController();
  TextEditingController donarPhone = TextEditingController();
  void updateDonar(docId) {
    final data = {
      'Name': donarName.text,
      'Phone': donarPhone.text,
      'Group': selectedGroup
    };
    donar.doc(docId).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donarName.text = args['Name'];
    donarPhone.text = args['Phone'];
    selectedGroup = args['Group'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Update details"),
        backgroundColor: Colors.redAccent,
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
                value: selectedGroup,
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
                updateDonar(docId);
                Navigator.pop(context);
              },
              child: Text(
                "Update",
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}

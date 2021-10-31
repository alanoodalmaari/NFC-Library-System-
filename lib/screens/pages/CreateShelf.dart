import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_library/screens/pages/StaffHomePage.dart';

import 'StudentHomePage.dart';


void main()=>runApp(MaterialApp(home: CreateShelf(),));

class CreateShelf extends StatefulWidget {
  @override
  _CreateShelfState createState() => _CreateShelfState();
}
Color primaryColor =Colors.white;
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.greenAccent;
final _formKey = GlobalKey<FormState>();
String shelfID, nfcID, category;
int capacity;
bool status;

class _CreateShelfState extends State<CreateShelf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffHomePage(),));
          },
        ),
        backgroundColor: Colors.greenAccent, shadowColor: null,
        title: Text("Create Shelf"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text(
                  "Shelf ID",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Shelf ID",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    shelfID=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Shelf ID';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "NFC_ID",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter NFC_ID",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    nfcID=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter NFC ID';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  //initialValue: _newBook.publishedYear,
                  decoration: InputDecoration(
                    hintText: "Enter Shelf category",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    category=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Book Published Date';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Capacity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  //initialValue: _newBook.publishedYear,
                  decoration: InputDecoration(
                    hintText: "Enter Shelf Capacity",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    capacity=int.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Shelf Capacity';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                  title: Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FlatButton.icon(
                          label: const Text('Full'),
                          icon: Radio(
                            value: true,
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status=value;
                              });
                            },
                          ),
                          onPressed: () {
                            setState(() {
                              status=true;
                            });
                          },
                        ),
                        FlatButton.icon(
                          label: const Text('Missing books'),
                          icon: Radio(
                            value: false,
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                          onPressed: () {
                            setState(() {
                              status = false;
                            });
                          },
                        )
                      ])),
            ),
            ButtonBar(
              buttonMinWidth: double.maxFinite,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      createRequest(capacity,nfcID,shelfID,category,status);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffHomePage(),));
                    }
                  },
                  child: Text("Create"),
                  color: Colors.green,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> createRequest(int capacity, String nfcID, String shelfID, String category, bool status) async {
  CollectionReference shelf = FirebaseFirestore.instance.collection('Shelf');
  FirebaseAuth auth = FirebaseAuth.instance;
  shelf.add({'Capacity': capacity, 'NFC_ID': nfcID, 'Shelf_ID':shelfID, 'category':category,'status': false});
  return;
}

/*

*/
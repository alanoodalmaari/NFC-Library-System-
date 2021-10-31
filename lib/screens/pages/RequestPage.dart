import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:cloud_firestore/cloud_firestore.dart';

import 'StudentHomePage.dart';


void main()=>runApp(MaterialApp(home: RequestPage(),));

class RequestPage extends StatefulWidget {
  @override
  _RequestBookState createState() => _RequestBookState();
}
Color primaryColor =Colors.white;
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;
final _formKey = GlobalKey<FormState>();
String title, author, pubYr;

class _RequestBookState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentHomePage(),));
          },
        ),
        backgroundColor: Colors.blue, shadowColor: null,
        title: Text("Request a book"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text(
                  "Title",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Title",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    title=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Book Id';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Author",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Author",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    author=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Book Title';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Published Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  //initialValue: _newBook.publishedYear,
                  decoration: InputDecoration(
                    hintText: "Enter Book Published Date",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    pubYr=value;
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
            ButtonBar(
              buttonMinWidth: double.maxFinite,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      createRequest(title, author, pubYr);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentHomePage(),));
                    }
                  },
                  child: Text("Request"),
                  color: Colors.blueAccent,
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

Future<void> createRequest(String title, String author, String publishYear) async {
  CollectionReference users = FirebaseFirestore.instance.collection('RequestedBooks');
  FirebaseAuth auth = FirebaseAuth.instance;
  users.add({'title': title, 'author': author, 'publish year':publishYear, 'approved':false});
  return;
}

/*

*/
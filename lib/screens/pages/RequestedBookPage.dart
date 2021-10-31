import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'StaffHomePage.dart';

// ignore: must_be_immutable
class RequestedBookPage extends StatefulWidget {
  @override
  _RequestedBookPageState createState() => _RequestedBookPageState();
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _RequestedBookPageState extends State<RequestedBookPage> {

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
        title: Text("Requested Books"),
      ),
      body: getRequestedBooks(),
    );
  }
}

Widget getRequestedBooks() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('RequestedBooks').where('approved',isEqualTo: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading Data...');
        }
        return ListView(
          children: snapshot.data.docs.map((document) {
            return Container(
              child: Card(
                color: Colors.white12,
                child:
                Column(
                  children: [
                    Card(
                        elevation: 15,
                        child: ListTile(
                          title: Text("Title: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(document['title'],
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    Card(
                        elevation: 15,
                        child: ListTile(
                          title: Text("Author: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(document['author'],
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    Card(
                        elevation: 15,
                        child: ListTile(
                          title: Text("Publish Year",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(document['publish year'],
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    Card(
                        elevation: 15,
                        child: ListTile(
                          title: Text("Approved: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(document['approved'].toString(),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ButtonBar(
                      buttonMinWidth: double.maxFinite,
                      buttonHeight: 40,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            FirebaseFirestore.instance.collection('RequestedBooks').doc(document.id).update({'approved': true});
                          },
                          child: Text("Approve"),
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                    ButtonBar(
                      buttonMinWidth: double.maxFinite,
                      buttonHeight: 40,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            FirebaseFirestore.instance.collection('RequestedBooks').doc(document.id).update({'approved': false});
                          },
                          child: Text("Reject"),
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

        );
      }
  );
}

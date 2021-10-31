import 'package:flutter/material.dart';
import 'package:nfc_library/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_library/screens/pages/StudentNFCScan.dart';

import 'StudentBookDetails.dart';
import 'package:intl/intl.dart';
import 'StudentHomePage.dart';

// ignore: must_be_immutable
class StudentNFC extends StatefulWidget {
  String userEmail;
  String userID;
  String nfcID;
  String userStatus;
  StudentNFC({this.userEmail,this.userID,this.userStatus,this.nfcID});

  @override
  _StudentNFCState createState() => _StudentNFCState(userEmail,userID,userStatus,nfcID);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StudentNFCState extends State<StudentNFC> {
  String userEmail;
  String userID;
  String nfcID;
  String userStatus;
  String username,programme, telNo, address;
  _StudentNFCState(this.userEmail,this.userID,this.userStatus,this.nfcID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: studentThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentNFCScan(userEmail: userEmail,userID: userID,userStatus: userStatus,),));
          },
        ),
        title: Text("NFC Book"),
      ),
      body: StreamBuilder(
              stream:  FirebaseFirestore.instance.collection('bookItem').where('nfcId',isEqualTo: nfcID).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading Data...');
                }
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    username=document['title'];
                    programme=document['bookId'];
                    telNo=document['nfcId'];
                    address=document['shelfId'];
                    return Container(
                      child: Card(
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
                                  title: Text("Book ID: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(document['bookId'],
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
                                  title: Text("NFC ID: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(document['nfcId'],
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
                                  title: Text("Shelf ID: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(document['shelfId'],
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            ButtonBar(
                              buttonMinWidth: double.maxFinite,
                              buttonHeight: 40,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () async {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentBookDetails(userEmail: userEmail,userStatus: userStatus,userID: userID,nfcID: nfcID,),));
                                  },
                                  child: Text("View Book Details"),
                                  color: Colors.blueAccent,
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
                                    DateTime now = new DateTime.now();
                                    DateTime date = new DateTime(now.year, now.month, now.day);
                                    DateFormat formatter = DateFormat('yyyy-MM-dd');
                                    String formatted = formatter.format(now);
                                    if(document['reader'] == null)
                                    FirebaseFirestore.instance.collection('bookItem').doc(document.id).update({'status': false,'reader': userEmail,'borrow date': formatted,});
                                  },
                                  child: Text("Borrow Book"),
                                  color: Colors.blueAccent,
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
                                    DateTime now = new DateTime.now();
                                    DateTime date = new DateTime(now.year, now.month, now.day);
                                    DateFormat formatter = DateFormat('yyyy-MM-dd');
                                    String formatted = formatter.format(now);
                                    FirebaseFirestore.instance.collection('bookItem').doc(document.id).update({'status': true,'borrowed': false,'return date': formatted,'reader': " "});
                                  },
                                  child: Text("Return Book"),
                                  color: Colors.blueAccent,
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
              }),
    );
  }

}



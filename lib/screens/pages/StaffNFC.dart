import 'package:flutter/material.dart';
import 'package:nfc_library/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_library/screens/pages/StaffBookDetails.dart';
import 'package:nfc_library/screens/pages/StaffNFCScan.dart';
import 'package:nfc_library/screens/pages/StudentNFCScan.dart';

import 'StudentBookDetails.dart';
import 'StudentHomePage.dart';

// ignore: must_be_immutable
class StaffNFC extends StatefulWidget {
  String userEmail;
  String userID;
  String nfcID;
  String userStatus;
  StaffNFC({this.userEmail,this.userID,this.userStatus,this.nfcID});

  @override
  _StaffNFCState createState() => _StaffNFCState(userEmail,userID,userStatus,nfcID);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StaffNFCState extends State<StaffNFC> {
  String userEmail;
  String userID;
  String nfcID;
  String userStatus;
  String username,programme, telNo, address;
  _StaffNFCState(this.userEmail,this.userID,this.userStatus,this.nfcID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: staffThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffNFCScan(userEmail: userEmail,userID: userID,userStatus: userStatus,),));
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

                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffBookDetails(userEmail: userEmail,userStatus: userStatus,userID: userID,nfcID: nfcID,),));
                              },
                              child: Text("View Book Details"),
                              color: Colors.green,
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



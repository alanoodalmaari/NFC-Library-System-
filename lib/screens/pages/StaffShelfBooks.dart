import 'package:flutter/material.dart';
import 'package:nfc_library/components/components.dart';
import 'package:nfc_library/screens/pages/StaffBookDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_library/screens/pages/StaffNFCScan.dart';
import 'package:nfc_library/screens/pages/StaffShelf.dart';
import 'package:nfc_library/screens/pages/StudentNFCScan.dart';

// ignore: must_be_immutable
class StaffShelfBooks extends StatefulWidget {
  String userEmail;
  String nfcID;
  String shelfID;
  String userID;
  String userStatus;
  StaffShelfBooks({this.userEmail,this.userID,this.userStatus, this.nfcID, this.shelfID});

  @override
  _StaffShelfBooksState createState() => _StaffShelfBooksState(userEmail,userID,userStatus,nfcID,shelfID);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StaffShelfBooksState extends State<StaffShelfBooks> {
  String userEmail;
  String userID;
  String nfcID;
  String shelfID="";
  String userStatus;
  String username,programme, telNo, address;
  _StaffShelfBooksState(this.userEmail,this.userID,this.userStatus,this.nfcID,this.shelfID);

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
        title: Text("NFC Shelf"),
      ),
      body: StreamBuilder(
          stream:  FirebaseFirestore.instance.collection('Shelf').where('Shelf_ID',isEqualTo: shelfID).snapshots(),
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
                              title: Text("Shelf ID: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(document['Shelf_ID'],
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
                              subtitle: Text(document['NFC_ID'],
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
                              title: Text("Books in: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(document['Books in'].toString(),
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
                              title: Text("Books out: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(document['Books out'].toString(),
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
                              title: Text("Category: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(document['category'],
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
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffShelf(userEmail: userEmail,userID: userID,userStatus: userStatus,shelfID: shelfID,),));
                              },
                              child: Text("View Books"),
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



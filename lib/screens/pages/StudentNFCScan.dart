import 'package:flutter/material.dart';
import 'package:nfc_library/components/components.dart';
import 'file:///D:/BennyAppsPrototypes/nfc_library/lib/screens/pages/ShelfBooks.dart';
import 'package:nfc_library/screens/pages/StudentNFCBook.dart';
import 'package:nfc_library/screens/pages/StudentHomePage.dart';

// ignore: must_be_immutable
class StudentNFCScan extends StatefulWidget {
  String userEmail;
  String nfcID;
  String shelfID;
  String userID;
  String userStatus;
  StudentNFCScan({this.userEmail,this.userID,this.userStatus, this.nfcID,this.shelfID});

  @override
  _StudentNFCScanState createState() => _StudentNFCScanState(userEmail,userID,userStatus,nfcID,shelfID);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StudentNFCScanState extends State<StudentNFCScan> {
  String userEmail;
  String userID;
  String nfcID;
  String shelfID;
  String userStatus;
  String username,programme, telNo, address;
  _StudentNFCScanState(this.userEmail,this.userID,this.userStatus,this.nfcID,this.shelfID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: studentThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentHomePage(userName: username,userID: userID,userStatus: userStatus,),));
          },
        ),
        title: Text("NFC Scan"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Center(
            child: RaisedButton(
              color: Colors.transparent,
              elevation: 0,
              child: IconButton(
                icon: Icon(Icons.nfc_outlined),
                iconSize: 300,
              ),
              onLongPress: (){
                  shelfID = "SF_2";
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        ShelfBooks(userEmail: userEmail,
                          userID: userID,
                          userStatus: userStatus,
                          nfcID: nfcID,shelfID: shelfID,),));
              },
              onPressed: () {
                nfcID = "NFC_BK121";
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      StudentNFC(userEmail: userEmail,
                        userID: userID,
                        userStatus: userStatus,
                        nfcID: nfcID,),));
              },
            ),

          ),
          Center(child: Container(child: Row(
            children: [
              SizedBox(width: 100,),
              Text("Tap ",style: TextStyle(color: Colors.blue,fontSize: 20),),
              Icon(Icons.nfc),
              Text(" to scan with NFC",style: TextStyle(color: Colors.blue,fontSize: 20),),
            ],
          ))),
        ],
      ),
    );
  }

}



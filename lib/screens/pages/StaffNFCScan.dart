import 'package:flutter/material.dart';
import 'package:nfc_library/components/components.dart';
import 'package:nfc_library/screens/pages/StaffHomePage.dart';
import 'StaffNFC.dart';
import 'StaffShelfBooks.dart';
import 'file:///D:/BennyAppsPrototypes/nfc_library/lib/screens/pages/ShelfBooks.dart';
import 'package:nfc_library/screens/pages/StudentNFCBook.dart';
import 'package:nfc_library/screens/pages/StudentHomePage.dart';

// ignore: must_be_immutable
class StaffNFCScan extends StatefulWidget {
  String userEmail;
  String nfcID;
  String shelfID;
  String userID;
  String userStatus;
  StaffNFCScan({this.userEmail,this.userID,this.userStatus, this.nfcID,this.shelfID});

  @override
  _StaffNFCScanState createState() => _StaffNFCScanState(userEmail,userID,userStatus,nfcID,shelfID);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StaffNFCScanState extends State<StaffNFCScan> {
  String userEmail;
  String userID;
  String nfcID;
  String shelfID;
  String userStatus;
  String username,programme, telNo, address;
  _StaffNFCScanState(this.userEmail,this.userID,this.userStatus,this.nfcID,this.shelfID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: staffThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffHomePage(userName: username,userID: userID,userStatus: userStatus,),));
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
                      StaffShelfBooks(userEmail: userEmail,
                        userID: userID,
                        userStatus: userStatus,
                        nfcID: nfcID,shelfID: shelfID,),));
              },
              onPressed: () {
                nfcID = "111";
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      StaffNFC(userEmail: userEmail,
                        userID: userID,
                        userStatus: userStatus,
                        nfcID: nfcID,),));
              },
            ),

          ),
          Center(child: Container(child: Row(
            children: [
              SizedBox(width: 100,),
              Text("Tap ",style: TextStyle(color: Colors.green,fontSize: 20),),
              Icon(Icons.nfc),
              Text(" to scan with NFC",style: TextStyle(color: Colors.green,fontSize: 20),),
            ],
          ))),
        ],
      ),
    );
  }

}



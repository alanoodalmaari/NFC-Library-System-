import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_event.dart';
import 'package:nfc_library/components/components.dart';
import 'package:nfc_library/screens/pages/StaffHomePage.dart';
import 'package:nfc_library/screens/pages/StaffUpdateProfile.dart';
import 'package:nfc_library/screens/pages/StudentUpdateProfile.dart';
import '../../main.dart';
import 'StudentHomePage.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class StaffProfile extends StatefulWidget {
  String userEmail;
  String userID;
  String userStatus;
  StaffProfile({this.userEmail,this.userID,this.userStatus});

  @override
  _StaffProfileState createState() => _StaffProfileState(userEmail,userID,userStatus);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StaffProfileState extends State<StaffProfile> {
  String userEmail;
  String userID;
  String userStatus;
  String username,programme, telNo, address;
  _StaffProfileState(this.userEmail,this.userID,this.userStatus);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: staffThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffHomePage(userName: username,userStatus: userStatus,userID: userID,),));
          },
        ),
        title: Text("Profile"),
      ),
      body: StreamBuilder(
          stream:  FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: userEmail).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading Data...');
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                username=document['username'];
                programme=document['programme'];
                telNo=document['tel_no'];
                address=document['address'];
                return Column(
                    children: <Widget>[
                      Card(
                          elevation: 15,
                          child: ListTile(
                            title: Text("User Email:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(userEmail,
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
                            title: Text("User ID:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(userID,
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
                            title: Text("Username: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(document['username'],
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
                            title: Text("Programme: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(document['programme'],
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
                            title: Text("Telephone: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(document['tel_no'],
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
                            title: Text("Status: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(document['admin'],
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.update),
                              color: Colors.green,
                              iconSize: 50,
                              onPressed: () async {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffUpdateProfile(userEmail: userEmail,userID: userID,userStatus: userStatus,username: username,telNo: telNo,programme: programme,address: address,),));
                              },
                            ),
                            Text("Update"),
                          ],
                        ),
                      ),
                    ]
                );
              }).toList(),

            );
          }),
    );
  }

}



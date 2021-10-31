import 'package:flutter/material.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_library/components/components.dart';
import 'package:nfc_library/screens/pages/StudentProfile.dart';


void main()=>runApp(MaterialApp(home: StudentUpdateProfile(),));

// ignore: must_be_immutable
class StudentUpdateProfile extends StatefulWidget {
  String userEmail;
  String userID;
  String userStatus;
  String username,programme, telNo, address;
  StudentUpdateProfile({this.userEmail,this.userID,this.userStatus,this.username,this.programme, this.telNo, this.address});

  @override
  _StudentUpdateProfileState createState() => _StudentUpdateProfileState(userEmail,userID,userStatus,username,programme, telNo, address);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StudentUpdateProfileState extends State<StudentUpdateProfile> {
  String userEmail;
  String userID;
  String userStatus;
  String username,programme, telNo, address;
  final _formKey = GlobalKey<FormState>();
  _StudentUpdateProfileState(this.userEmail,this.userID,this.userStatus,this.username,this.programme, this.telNo, this.address);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentProfile(userEmail: userEmail,userID: userID,userStatus: userStatus,),));
          },
        ),
        backgroundColor: studentThemeColor, shadowColor: null,
        title: Text("Update Profile"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Username",
                    border: const OutlineInputBorder(),
                  ),
                  initialValue: username,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    //title=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Telephone Number",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Tel No",
                    border: const OutlineInputBorder(),
                  ),
                  initialValue: telNo,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    telNo=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter tel number';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Programme",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Programme",
                    border: const OutlineInputBorder(),
                  ),
                  initialValue: programme,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    programme=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Programme';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Address",
                    border: const OutlineInputBorder(),
                  ),
                  initialValue: address,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    address=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Address';
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
                      updateProfile(username, programme, telNo, address,userEmail);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentProfile(userEmail: userEmail,userID: userID,userStatus: userStatus)));
                    }
                  },
                  child: Text("Update"),
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

Future<void> updateProfile(String username,String programme,String telNo,String address,String userEmail) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  users.doc(userEmail).update({'email': userEmail,'username': username, 'programme': programme, 'tel_no':telNo, 'address':address});
  return;
}

/*

*/
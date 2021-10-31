import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_event.dart';
import 'package:nfc_library/components/components.dart';
import 'package:nfc_library/main.dart';
import 'package:nfc_library/screens/pages/StaffNFCScan.dart';
import 'StudentNFCScan.dart';
import 'StudentProfile.dart';
import 'file:///D:/BennyAppsPrototypes/nfc_library/lib/screens/pages/StaffShelf.dart';
import 'package:nfc_library/screens/pages/CreateShelf.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/StaffBooks.dart';
import 'package:nfc_library/screens/pages/StaffSearch.dart';

import 'RequestedBookPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_restart/flutter_restart.dart';

import 'StaffProfile.dart';

// ignore: must_be_immutable
class StaffHomePage extends StatefulWidget {
  StaffHomePage({this.userName, this.userID, this.userStatus});
  final String userName;
  final String userID;
  String userStatus;

  @override
  _StaffHomePageState createState() => _StaffHomePageState(userStatus);
}

class _StaffHomePageState extends State<StaffHomePage> {
  final GlobalKey _menuKey = new GlobalKey();
  String userStatus;
  final FirebaseAuth user = FirebaseAuth.instance;
  _StaffHomePageState(this.userStatus);

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
        key: _menuKey,
        icon: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 35,
          ),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
          new PopupMenuItem<String>(child: const Text('NFC'), value: 'NFC'),
          new PopupMenuItem<String>(child: const Text('Profile'), value: 'Profile'),
          new PopupMenuItem<String>(child: const Text('Logout'), value: 'Logout'),
        ],
        onSelected: (value) async {
          if(value=='NFC') Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffNFCScan(userStatus: userStatus,userID: user.currentUser.uid.toString(),userEmail: user.currentUser.email.toString(),),));
          //if(value=='NFC_Shelf') Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentSearch(),));
          if(value=='Profile') {
            String userStatus="";
            String isAdmin;
            FirebaseAuth user = FirebaseAuth.instance;
            final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

            getData() async {
              return await _fireStore.collection('Users').doc(user.currentUser.email.toString()).get();
            }
            getData().then((val){
              isAdmin = val.get('admin');
              print(isAdmin.toString());
            });


              userStatus = isAdmin;

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  StaffProfile(userEmail: user.currentUser.email.toString(),
                    userID: user.currentUser.uid.toString(),
                    userStatus: userStatus,),));
          }
          if(value=='Logout') {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLoggedOut());
            final result = await FlutterRestart.restartApp();
            return result;
          }
        });

    final tile = new ListTile(
        title: new Text( "signed in as \n"+user.currentUser.email,
          style: TextStyle(color: Colors.white),
        ),
        trailing: button,
        onTap: () {
          // This is a hack because _PopupMenuButtonState is private.
          dynamic state = _menuKey.currentState;
          state.showButtonMenu();
        });
    return Scaffold(
      appBar: AppBar(
          backgroundColor: staffThemeColor,
          title: tile

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              child: new Text(
                'Welcome to NFC Library',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            MainButton(
              child: Text('Search for a book'),
              themeColor: staffThemeColor,
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffSearch(),));
              },
            ),
            MainButton(
              child: Text('Books'),
              themeColor: staffThemeColor,
              onPressed: () {
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ViewAllBook(),));
                staffBooks();
              },
            ),
            MainButton(
              child: Text('View Requests'),
              themeColor: staffThemeColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestedBookPage()),
                );
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

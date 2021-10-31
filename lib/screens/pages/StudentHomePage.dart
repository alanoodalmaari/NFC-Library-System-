import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_event.dart';
import 'package:nfc_library/components/components.dart';
import 'package:nfc_library/screens/pages/StudentHistory.dart';
import 'package:nfc_library/screens/pages/StudentNFCScan.dart';
import 'package:nfc_library/screens/pages/StudentProfile.dart';
import 'StudentNFCBook.dart';
import 'RequestPage.dart';
import 'StudentSearch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_restart/flutter_restart.dart';

// ignore: must_be_immutable
class StudentHomePage extends StatefulWidget {
  StudentHomePage({this.userName, this.userID, this.userStatus});
  final String userName;
  final String userID;
  String userStatus;

  @override
  _StudentHomePageState createState() => _StudentHomePageState(userStatus);
}

class _StudentHomePageState extends State<StudentHomePage> {
  final GlobalKey _menuKey = new GlobalKey();
  String userStatus;
  final FirebaseAuth user = FirebaseAuth.instance;
  _StudentHomePageState(this.userStatus);

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
          if(value=='NFC') Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentNFCScan(),));
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
                  StudentProfile(userEmail: user.currentUser.email.toString(),
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
        backgroundColor: studentThemeColor,
        title: tile

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(""),
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
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentSearch(),));
              },
            ),
            MainButton(
              child: Text('Request a book'),
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RequestPage(),));

              },
            ),
            MainButton(
              child: Text('View History'),
              themeColor: studentThemeColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentHistory(userEmail: user.currentUser.email.toString(),)),
                );
              },
            ),
           /* MainButton(
              child: Text('View history'),
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RequestPage(),));
              },
            ),*/
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${user.displayName ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Email: ${user.email ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
        ),
      ],
    );
  }

  Future<String> getUserStatus(String userEmail, String userStatus) async {
    String isAdmin;
    FirebaseAuth user = FirebaseAuth.instance;
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

    getData() async {
      return await _fireStore.collection('Users').doc(userEmail).get();
    }
    getData().then((val){
      isAdmin = val.get('admin');
      print(isAdmin.toString());
    });

    if(isAdmin == "false")
      userStatus = "Student";
    else if(isAdmin == "true")
      // ignore: unnecessary_statements
      userStatus == "Admin";

    return userStatus;
  }
}

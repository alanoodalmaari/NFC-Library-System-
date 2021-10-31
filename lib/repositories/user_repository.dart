import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository()
      : _firebaseAuth = FirebaseAuth.instance;


  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser =  _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getUser() async {
    return  _firebaseAuth.currentUser;
  }

  // ignore: missing_return
  Future<Widget> createRecord(String email) async {
  var databaseReference = FirebaseFirestore.instance;
    await FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'admin': false,
    });
  }

  /*authorizeAccess(BuildContext context){
    FirebaseAuth.instance.currentUser.then((user){
      FirebaseFirestore.instance.collection('users').where('admin', isEqualTo: user.email).get().then((docs){
        if(docs.documents[0].exists){
          if(docs.documents[0].data['admin'] = true){
            Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context)=> StaffHomePage()
            ));
          }
          else{
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (BuildContext context)=> StudentHomePage()
                ));
          }
        }
      });
    });
  }*/
}



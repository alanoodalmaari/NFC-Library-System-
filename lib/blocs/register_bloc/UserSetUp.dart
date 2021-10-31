import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> userSetup(String email, var userID) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  users.doc(userID).set({'email': email, 'admin': "Student", });
  return;
}

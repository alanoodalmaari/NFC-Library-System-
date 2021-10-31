import 'package:flutter/material.dart';
import 'package:nfc_library/components/components.dart';
import 'StudentHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class StudentHistory extends StatefulWidget {
  String userEmail;
  String userID;
  String userStatus;
  StudentHistory({this.userEmail,this.userID,this.userStatus});

  @override
  _StudentHistoryState createState() => _StudentHistoryState(userEmail,userID,userStatus);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StudentHistoryState extends State<StudentHistory> {
  String userEmail;
  String userID;
  String userStatus;
  String username,programme, telNo, address;
  _StudentHistoryState(this.userEmail,this.userID,this.userStatus);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: studentThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentHomePage(),));
          },
        ),
        title: Text("History"),
      ),
      body: StreamBuilder(
          stream:  FirebaseFirestore.instance.collection('bookItem').where('reader',isEqualTo: userEmail).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading Data...');
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                username=document['title'];
                programme=document['bookId'];
                telNo=document['nfcId'];
                address=document['category'];
                return Container(
                    child: Card(
                      color: Colors.white12,
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
                          Card(
                              elevation: 15,
                              child: ListTile(
                                title: Text("Borrowed Date: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(document['borrow date'],
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
                                title: Text("Returned Date: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(document['return date'],
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
                              )
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



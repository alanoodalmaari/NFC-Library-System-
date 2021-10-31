import 'package:flutter/material.dart';
import 'package:nfc_library/components/components.dart';
import 'package:nfc_library/screens/pages/StudentNFCBook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_library/screens/pages/StudentNFCScan.dart';

// ignore: must_be_immutable
class StudentBookDetails extends StatefulWidget {
  String userEmail;
  String nfcID;
  String userID;
  String userStatus;
  StudentBookDetails({this.userEmail,this.userID,this.userStatus, this.nfcID});

  @override
  _StudentBookDetailsState createState() => _StudentBookDetailsState(userEmail,userID,userStatus,nfcID);
}

Color primaryColor =Colors.indigo[100];
Color secondaryColor = Colors.indigo;
Color logoColor = Colors.lightBlueAccent;



class _StudentBookDetailsState extends State<StudentBookDetails> {
  String userEmail;
  String userID;
  String nfcID;
  String userStatus;
  String username,programme, telNo, address;
  _StudentBookDetailsState(this.userEmail,this.userID,this.userStatus,this.nfcID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: studentThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentNFCScan(userEmail: userEmail,userID: userID,userStatus: userStatus,),));
          },
        ),
        title: Text("Book Details"),
      ),
      body: StreamBuilder(
          stream:  FirebaseFirestore.instance.collection('bookItem').where('nfcId',isEqualTo: nfcID).snapshots(),
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
                String status = "";
                if(document['status'])
                  status = "Unavailable";
                else
                  status = "Available";
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
                              title: Text("Shelf ID: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(document['shelfId'],
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
                              title: Text("Publish Year: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(document['publishedYear'],
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
                              title: Text("Description: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(document['description'],
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
                              title: Text("Author: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(document['author'],
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
                              subtitle: Text(status,
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



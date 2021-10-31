import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SearchService.dart';
import 'StudentHomePage.dart';

void main() async {
  // FIREBASE INTIALIZAITON
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp((new StudentSearch()));
}

class StudentSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(String value) {
    if (value.length != 0) {
      var capitalizedValue =
          value.substring(0, 1).toUpperCase() + value.substring(1);
      SearchService()
          .searchByAuthor(capitalizedValue)
          .then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; i++) {
          print(docs.docs[i].data()['author']);
          setState(() {
            // ADDING BOOK DATA WITH ITS DOCUMENT ID
            queryResultSet.add({'id': docs.docs[i].id, ...docs.docs[i].data()});
            // FROM ALL BOOKS IN QUERY LIST PUT IN THEM IN STORE LSIT
            queryResultSet.forEach((element) {
              if (element['author'].toString().startsWith(capitalizedValue)) {
                setState(() {
                  // ADD BOOKS THAT DOESNT ALREADY EXIST IN STORE LIST, TO NOT ADD DOUBLES
                  if (tempSearchStore
                      .indexWhere((book) => book['id'] == element['id']) <
                      0) {
                    tempSearchStore.add(element);
                  }
                });
              }
            });
          });
        }
      });
    } else {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    // OLD CODE

    // if (queryResultSet.length == 0 && value.length != 0) {
    //   SearchService()
    //       .searchByAuthor(capitalizedValue)
    //       .then((QuerySnapshot docs) {
    //     for (int i = 0; i < docs.docs.length; i++) {
    //       print(docs.docs[i].data()['author']);
    //       queryResultSet.add(docs.docs[i].data());
    //     }
    //   });
    // } else {
    //   tempSearchStore = [];
    //   queryResultSet.forEach((element) {
    //     if (element['author'].toString().startsWith(capitalizedValue)) {
    //       setState(() {
    //         tempSearchStore.add(element);
    //       });
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Search'),
    leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentHomePage(),));
        },)
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element);
              }).toList())
        ]));
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(
                data['author'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ))));
}



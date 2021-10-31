
import 'package:flutter/material.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/read_book.dart';
import 'package:nfc_library/screens/pages/StaffHomePage.dart';
import 'add_book.dart';
import 'api/BookRestController.dart';
import 'constant/constant.dart';
import 'model/bookItem.dart';

class ViewAllBook extends StatefulWidget {
  ViewAllBook();
  @override
  _ViewAllBookState createState() => _ViewAllBookState();
}

class _ViewAllBookState extends State<ViewAllBook> {
  List<BookItem> _bookItems;
  final dataService = BookRestController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookItem>>(
        future: dataService.getAllBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _bookItems = snapshot.data;
            return _buildAllBookScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildAllBookScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffHomePage(),));
          },
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text("Library Management"),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            buttonMinWidth: double.maxFinite,
            children: <Widget>[
              FlatButton(
                child: Text("ADD BOOK"),
                color: Colors.greenAccent,
                textColor: Colors.white,
                onPressed: () async {
                  BookItem _newBook =
                      await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AddBook(),));
                  if (_newBook != null) {
                    setState(() {
                      _bookItems.add(_newBook);
                    });
                  }
                },
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(
                        _bookItems[index].title!=null?_bookItems[index].title:'* --null value!-- *',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ReadBook(_bookItems[index]),));
                        final value = await Navigator.pushNamed(
                          context,
                          READ_BOOK,
                          arguments: _bookItems[index],
                        );

                        if (value == "Delete") {
                          await _deleteBookItem(index, context);
                        } else if (value == "Update") {
                          await _updateBookItem(context, index);
                        }
                      },
                    ),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.blueGrey,
                    ),
                itemCount: _bookItems.length),
          ),
        ],
      ),
    );
  }

  Future _updateBookItem(BuildContext context, int index) async {
    BookItem newBook = await Navigator.pushNamed(
      context,
      UPDATE_BOOK,
      arguments: BookItem.copy(_bookItems[index]),
    );
    if (newBook != null) {
      setState(() {
        _bookItems[index] = newBook;
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Book is updated"),
        ));
      });
    }
  }

  Future _deleteBookItem(int index, BuildContext context) async {
    await dataService.deleteBookItem(_bookItems[index].id);
    setState(() {
      _bookItems.removeAt(index);
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Book is deleted"),
      ));
    });
  }

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching All Books... Please wait'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_library/api/BookRestController.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/StaffBooks.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/update_book.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/view_all_book.dart';
import 'model/bookItem.dart';

class ReadBook extends StatefulWidget {
  final BookItem _bookItem;
  ReadBook(this._bookItem);
  @override
  _ReadBookState createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final BookRestController bookOperation = new BookRestController();

  @override
  Widget build(context) {
    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text("Book"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ViewAllBook(),));
            },
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        body: ListView(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: _flatButtonWithParam("Delete",widget._bookItem, widget._bookItem.bookId.toString())),
                  SizedBox(width: 5),
                  Expanded(child: _flatButtonWithParam("Update",widget._bookItem, widget._bookItem.bookId.toString())),
                ],
              ),
            ),
            _cardWithParam("Book ID", widget._bookItem.bookId),
            _cardWithParam("Title", widget._bookItem.title),
            _cardWithParam("Published Date", widget._bookItem.publishedYear),
            _cardWithParam("Author", widget._bookItem.author),
            _cardWithParam("Category", widget._bookItem.category),
            _cardWithParam("Description", widget._bookItem.description),
            _cardWithParam(
                "Status",
                widget._bookItem.status == true
                    ? "Available"
                    : "Not Available"),
            _cardWithParam("Shelf ID", widget._bookItem.shelfId),
            _cardWithParam("NFC ID", widget._bookItem.nfcId),
          ],
        ));
  }

  RaisedButton _flatButtonWithParam(String operation, BookItem bookItem, String id) {
    return RaisedButton(
      child: Text(operation),
      color: Colors.greenAccent,
      textColor: Colors.white,
      onPressed: () {
        if(operation=="Update") {
          Navigator.pop(context, operation);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UpdateBook(bookItem),));
        }
        if(operation=="Delete") {
          Navigator.pop(context, operation);
          //staffBooks();
          //bookOperation.deleteBookItem(id);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewAllBook(),));
        }
      },
    );
  }

  Card _cardWithParam(String title, String subTitle) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subTitle),
      ),
    );
  }
}

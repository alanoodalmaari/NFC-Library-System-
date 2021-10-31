import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/view_all_book.dart';
import 'api/BookRestController.dart';
import 'model/bookItem.dart';

class UpdateBook extends StatefulWidget {
  final BookItem _bookItem;
  UpdateBook(this._bookItem);

  @override
  _UpdateBookState createState() => _UpdateBookState();
}

final _formKey = GlobalKey<FormState>();

class _UpdateBookState extends State<UpdateBook> {
  final dataService = BookRestController();

  @override
  Widget build(context) {
    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text("Update Book"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ViewAllBook(),));
            },
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ButtonBar(
                buttonMinWidth: double.maxFinite,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Future<BookItem> futureBookItem =
                        dataService.updateBookItem(
                            widget._bookItem.id, widget._bookItem);
                        futureBookItem.then((value) {
                          Navigator.pop(context, value);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ViewAllBook(),));
                        });
                      }
                    },
                    child: Text("Save"),
                    color: Colors.greenAccent,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Book ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextFormField(
                    initialValue: widget._bookItem.bookId,
                    decoration: InputDecoration(
                      hintText: "Enter Book ID",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        widget._bookItem.bookId = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Book Id';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Title",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextFormField(
                    initialValue: widget._bookItem.title,
                    decoration: InputDecoration(
                      hintText: "Enter Book Title",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      widget._bookItem.title = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Book Title';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Published Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextFormField(
                    initialValue: widget._bookItem.publishedYear,
                    decoration: InputDecoration(
                      hintText: "Enter Book Published Date",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        widget._bookItem.publishedYear = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Book Published Date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Author",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextFormField(
                    initialValue: widget._bookItem.author,
                    decoration: InputDecoration(
                      hintText: "Enter Book Author",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        widget._bookItem.author = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Book Author';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextFormField(
                    initialValue: widget._bookItem.category,
                    decoration: InputDecoration(
                      hintText: "Enter Book Category",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        widget._bookItem.category = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Book Category';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextFormField(
                    initialValue: widget._bookItem.description,
                    decoration: InputDecoration(
                      hintText: "Enter Book Description",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        widget._bookItem.description = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Book Description';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                    title: Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlatButton.icon(
                            label: const Text('Available'),
                            icon: Radio(
                              value: true,
                              groupValue: widget._bookItem.status,
                              onChanged: (value) {
                                setState(() {
                                  widget._bookItem.status = value;
                                });
                              },
                            ),
                            onPressed: () {
                              setState(() {
                                widget._bookItem.status = true;
                              });
                            },
                          ),
                          FlatButton.icon(
                            label: const Text('Not Available'),
                            icon: Radio(
                              value: false,
                              groupValue: widget._bookItem.status,
                              onChanged: (value) {
                                setState(() {
                                  widget._bookItem.status = value;
                                });
                              },
                            ),
                            onPressed: () {
                              setState(() {
                                widget._bookItem.status = false;
                              });
                            },
                          )
                        ])),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Shelf ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextFormField(
                    initialValue: widget._bookItem.shelfId,
                    decoration: InputDecoration(
                      hintText: "Enter Book Shelf ID",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        widget._bookItem.shelfId = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Book Shelf ID';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "NFC ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextFormField(
                    initialValue: widget._bookItem.nfcId,
                    decoration: InputDecoration(
                      hintText: "Enter Book NFC ID",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        widget._bookItem.nfcId = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Book NFC ID';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}


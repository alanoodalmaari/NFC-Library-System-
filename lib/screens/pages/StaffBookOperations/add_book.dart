import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/view_all_book.dart';
import 'api/BookRestController.dart';
import 'model/bookItem.dart';

class AddBook extends StatefulWidget {
  AddBook();
  @override
  _AddBookState createState() => _AddBookState();
}

final _formKey = GlobalKey<FormState>();

class _AddBookState extends State<AddBook> {
  BookItem _newBook = new BookItem(
      bookId: null,
      title: null,
      publishedYear: null,
      author: null,
      category: null,
      description: null,
      status: true,
      shelfId: null,
      nfcId: null);
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
        title: Text("Add Book"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ViewAllBook(),));
          },
        ),

      ),
      backgroundColor: Colors.grey.shade100,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ButtonBar(
              buttonMinWidth: double.maxFinite,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Future _newBookWithId = dataService.createBookItem(_newBook);
                      _newBookWithId.then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ViewAllBook(),)));
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
                  initialValue: _newBook.bookId,
                  decoration: InputDecoration(
                    hintText: "Enter Book ID",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _newBook.bookId = value;
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
                  initialValue: _newBook.title,
                  decoration: InputDecoration(
                    hintText: "Enter Book Title",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    _newBook.title = value;
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
                  initialValue: _newBook.publishedYear,
                  decoration: InputDecoration(
                    hintText: "Enter Book Published Date",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _newBook.publishedYear = value;
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
                  initialValue: _newBook.author,
                  decoration: InputDecoration(
                    hintText: "Enter Book Author",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _newBook.author = value;
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
                  initialValue: _newBook.category,
                  decoration: InputDecoration(
                    hintText: "Enter Book Category",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _newBook.category = value;
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
                  initialValue: _newBook.description,
                  decoration: InputDecoration(
                    hintText: "Enter Book Description",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _newBook.description = value;
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
                            groupValue: _newBook.status,
                            onChanged: (value) {
                              setState(() {
                                _newBook.status = value;
                              });
                            },
                          ),
                          onPressed: () {
                            setState(() {
                              _newBook.status = true;
                            });
                          },
                        ),
                        FlatButton.icon(
                          label: const Text('Not Available'),
                          icon: Radio(
                            value: false,
                            groupValue: _newBook.status,
                            onChanged: (value) {
                              setState(() {
                                _newBook.status = value;
                              });
                            },
                          ),
                          onPressed: () {
                            setState(() {
                              _newBook.status = false;
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
                  initialValue: _newBook.shelfId,
                  decoration: InputDecoration(
                    hintText: "Enter Book Shelf ID",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _newBook.shelfId = value;
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
                  initialValue: _newBook.nfcId,
                  decoration: InputDecoration(
                    hintText: "Enter Book NFC ID",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _newBook.nfcId = value;
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
      ),
    );
  }
}

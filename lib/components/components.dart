import 'package:flutter/material.dart';

class StudentBook {
  String id;
  String title;
  String publishedYear;
  String author;
  String category;
  String description;
  bool status;
  String shelfId;
  String nfcId;
  String searchKey;
  String bookId;

  StudentBook({
    this.id = '',
    this.title = '',
    this.publishedYear = '',
    this.author = '',
    this.category = '',
    this.description = '',
    status,
    this.shelfId = '',
    this.nfcId = '',
    this.searchKey = '',
    bookId,
  });

  StudentBook.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          bookId: json['bookId'],
          title: json['title'],
          publishedYear: json['publishedYear'],
          author: json['author'],
          category: json['category'],
          description: json['description'],
          status: json['status'],
          shelfId: json['shelfId'],
          nfcId: json['nfcId'],
        );

//to API
  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'title': title,
        'publishedYear': publishedYear,
        'author': author,
        'category': category,
        'description': description,
        'status': status,
        'shelfId': shelfId,
        'nfcId': nfcId,
      };
}

class MainButton extends StatelessWidget {
  MainButton({
    Key key,
    this.child,
    this.onPressed,
    this.themeColor = studentThemeColor,
  }) : super(key: key);
  final Widget child;
  final Color themeColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: this.child,
      onPressed: onPressed,
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(new Size(300, 30)),
          backgroundColor: MaterialStateProperty.all<Color>(themeColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  DetailsContainer({
    Key key,
    this.title,
    this.value,
  }) : super(key: key);
  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      height: 70,
      padding: const EdgeInsets.all(13),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              this.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              this.value,
              style: TextStyle(color: Colors.blueGrey),
            )
          ]),
    );
  }
}

const studentThemeColor = const Color(0xFF3B82F6);
const staffThemeColor = const Color(0xFF34D399);

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('loading...'),
          ],
        ),
      ),
    );
  }
}

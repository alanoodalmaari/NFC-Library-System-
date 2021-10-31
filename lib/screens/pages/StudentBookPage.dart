/*import 'package:flutter/material.dart';
import 'package:nfc_library/nfcLibrary/components/components.dart';

import 'Staff/api/BookRestController.dart';

class StudentBookPage extends StatelessWidget {
  StudentBook _bookItem;
  final dataService = BookRestController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StudentBook>(
        future: dataService.getBookItem('p5V07xGRg3BuqNcdravZ'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _bookItem = snapshot.data;
            return StudentBookWidget(
              book: _bookItem,
            );
          }
          return LoadingWidget();
        });
  }
}

class StudentBookWidget extends StatelessWidget {
  StudentBookWidget({Key key, this.book}) : super(key: key);
  final StudentBook book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: studentThemeColor,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.qr_code,
                    size: 26.0,
                  ),
                )),
          ],
          leading: new BackButton(
            color: Colors.white,
          ),
          title: Center(child: new Text(this.book.title))),
      body: ListView(
        children: <Widget>[
          DetailsContainer(
            title: 'Book Id',
            value: this.book.id,
          ),
          DetailsContainer(
            title: 'Title',
            value: this.book.title,
          ),
          DetailsContainer(
            title: 'Date Published',
            value: this.book.publishedYear,
          ),
          DetailsContainer(
            title: 'Author',
            value: this.book.author,
          ),
          DetailsContainer(
            title: 'Category',
            value: this.book.category,
          ),
          DetailsContainer(
            title: 'Description',
            value: this.book.description,
          ),
          DetailsContainer(
            title: 'Status',
            value: this.book.status.toString(),
          ),
          DetailsContainer(
            title: 'Shelf Id',
            value: this.book.shelfId,
          ),
          DetailsContainer(
            title: 'NFC Id',
            value: this.book.nfcId,
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

 */

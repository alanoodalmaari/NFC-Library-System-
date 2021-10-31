import 'package:flutter/cupertino.dart';

class BookItem {
  String id;
  String bookId;
  String title;
  String publishedYear;
  String author;
  String category;
  String description;
  bool status;
  String shelfId;
  String nfcId;

  BookItem({
    this.id,
    @required this.bookId,
    @required this.title,
    @required this.publishedYear,
    @required this.author,
    @required this.category,
    @required this.description,
    @required this.status,
    @required this.shelfId,
    @required this.nfcId,
  });

//constructor
  BookItem.copy(BookItem from)
      : this(
          id: from.id,
          bookId: from.bookId,
          title: from.title,
          publishedYear: from.publishedYear,
          author: from.author,
          category: from.category,
          description: from.description,
          status: from.status,
          shelfId: from.shelfId,
          nfcId: from.nfcId,
        );

//from API
  BookItem.fromJson(Map<String, dynamic> json)
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

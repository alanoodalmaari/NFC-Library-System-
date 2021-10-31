
import 'package:flutter/material.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/model/bookItem.dart';
import '../add_book.dart';
import '../read_book.dart';
import '../update_book.dart';
import '../view_all_book.dart';
import 'constant.dart';
Route<dynamic> createRoute(settings) {
  final arguments = settings.arguments;

  switch (settings.name) {
    case VIEW_ALL_BOOK:
      return MaterialPageRoute(
          settings: RouteSettings(name: VIEW_ALL_BOOK),
          builder: (context) => ViewAllBook());

    case READ_BOOK:
      return MaterialPageRoute(
          settings: RouteSettings(name: READ_BOOK),
          builder: (context) => ReadBook(arguments));

    case ADD_BOOK:
      return MaterialPageRoute<BookItem>(
          settings: RouteSettings(name: ADD_BOOK),
          builder: (context) => AddBook());

    case UPDATE_BOOK:
      return MaterialPageRoute<BookItem>(
          settings: RouteSettings(name: UPDATE_BOOK),
          builder: (context) => UpdateBook(arguments));
  }

  return null;
}

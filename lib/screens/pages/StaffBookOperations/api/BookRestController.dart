import 'package:nfc_library/screens/pages/StaffBookOperations/model/bookItem.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/service/BookService.dart';

class BookRestController {
  static final BookRestController _instance = BookRestController._constructor();
  factory BookRestController() {
    return _instance;
  }

  BookRestController._constructor();
  final bookService = BookService();

  Future<List<BookItem>> getAllBooks() async {
    final listJson = await bookService.getBookItem('bookItem');

    return (listJson as List)
        .map((itemJson) => BookItem.fromJson(itemJson))
        .toList();
  }

  Future deleteBookItem(String id) async {
    await bookService.deleteBookItem('bookItem/$id');
  }

  Future<BookItem> createBookItem(BookItem bookItem) async {
    final json =
        await bookService.createBookItem('bookItem', bookItem.toJson());
    return BookItem.fromJson(json);
  }

  Future<BookItem> getBookItem(String id) async {
    final json = await bookService.getBookItem('bookItem/$id/');
    return BookItem.fromJson(json);
  }

  Future<BookItem> updateBookItem(String id, BookItem bookItem) async {
    final json =
        await bookService.updateBookItem('bookItem/$id/', bookItem.toJson());
    return BookItem.fromJson(json);
  }
}

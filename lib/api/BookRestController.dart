import 'package:nfc_library/components/components.dart';
import 'package:nfc_library/screens/pages/StaffBookOperations/service/BookService.dart';

class BookRestController {
  static final BookRestController _instance = BookRestController._constructor();

  factory BookRestController() {
    return _instance;
  }

  BookRestController._constructor();

  final bookService = BookService();

  Future<List<StudentBook>> getAllBooks() async {
    final listJson = await bookService.getBookItem('bookItem');

    return (listJson as List)
        .map((itemJson) => StudentBook.fromJson(itemJson))
        .toList();
  }

  Future deleteBookItem(String id) async {
    await bookService.deleteBookItem('bookItem/$id');
  }

  Future<StudentBook> createBookItem(StudentBook bookItem) async {
    final json =
        await bookService.createBookItem('bookItem', bookItem.toJson());
    return StudentBook.fromJson(json);
  }

  Future<StudentBook> getBookItem(String id) async {
    final json = await bookService.getBookItem('bookItem/$id/');
    return StudentBook.fromJson(json);
  }

  Future<StudentBook> updateBookItem(String id, StudentBook bookItem) async {
    final json =
        await bookService.updateBookItem('bookItem/$id/', bookItem.toJson());
    return StudentBook.fromJson(json);
  }
}

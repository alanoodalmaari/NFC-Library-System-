import 'dart:convert';

import 'package:http/http.dart' as http;

class BookService {
  static final BookService _instance = BookService._constructor();
  factory BookService() {
    return _instance;
  }

  BookService._constructor();

  static const String baseUrl =
      'https://us-central1-nfc-library-app.cloudfunctions.net/api';

  Future getBookItem(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future createBookItem(String endpoint, dynamic data) async {
    final response = await http.post(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future updateBookItem(String endpoint, dynamic data) async {
    final response = await http.patch(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future deleteBookItem(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }
}

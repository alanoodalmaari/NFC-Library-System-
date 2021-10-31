import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByAuthor(String searchFiled) {
    print(searchFiled);
    return FirebaseFirestore.instance
        .collection('bookItem')
        .where('searchKey',
        isEqualTo: searchFiled.substring(0, 1).toUpperCase())
        .get();
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constant/constant.dart';
import 'constant/router.dart';

void staffBooks() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: VIEW_ALL_BOOK,
    onGenerateRoute: createRoute,
  ));
}

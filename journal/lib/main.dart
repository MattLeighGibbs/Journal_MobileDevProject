import 'package:flutter/material.dart';

void main() {
  runApp(JournalApp());
}

class JournalApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Journal', home: Text('add 2 me'));
  }
}

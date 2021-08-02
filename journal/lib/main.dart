import 'package:flutter/material.dart';
import 'package:journal/main_journal_widget.dart';

void main() {
  runApp(JournalApp());
}

class JournalApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Journal', home: new MainJournalWidget());
  }
}

import 'package:flutter/material.dart';
import 'models/journal_entry_model.dart';

class JournalEntryDetail extends StatelessWidget {
  final JournalEntryModel entry;
  final bool isVertical;
  const JournalEntryDetail(
      {Key? key, required this.entry, required this.isVertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(entry.dateToString()),
        ),
        body: Column(children: [Text(entry.title), Text(entry.body)]));
  }
}

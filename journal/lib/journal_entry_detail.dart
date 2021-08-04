import 'package:flutter/material.dart';
import 'models/journal_entry_model.dart';

class JournalEntryDetail extends StatelessWidget {
  final JournalEntryModel entry;
  const JournalEntryDetail({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(entry.dateToString()),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(entry.title!, style: TextStyle(fontSize: 25)),
                Container(height: 10),
                Text(entry.body!)
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )));
  }
}

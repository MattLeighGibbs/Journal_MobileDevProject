import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry_model.dart';

class JournalEntrySummary extends StatelessWidget {
  final JournalEntryModel entry;
  const JournalEntrySummary({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(entry.title), Text(entry.dateToString())]);
  }
}

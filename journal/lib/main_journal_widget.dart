///
/// will contain the 'main page'.
/// wanted to separate this from the actual main file.
/// This should be the child of the scaffold or whatever is in main.
///

import 'package:flutter/material.dart';
import 'package:journal/journal_entry_summary.dart';
import 'models/journal_entry_model.dart';

class MainJournalWidget extends StatefulWidget {
  const MainJournalWidget({Key? key}) : super(key: key);

  @override
  _MainJournalWidgetState createState() => _MainJournalWidgetState();
}

class _MainJournalWidgetState extends State<MainJournalWidget> {
  List<JournalEntrySummary> _entries = fakeEntries();

  // void _updateEntries(JournalEntryModel entry) {
  //   setState(() {
  //     // _entries.add(entry);
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: _entries);
  }
}

List<JournalEntrySummary> fakeEntries() {
  var temp = new JournalEntryModel(
      body: "Test body",
      date: DateTime.now(),
      id: 1,
      rating: 1,
      title: "test title");
  return [new JournalEntrySummary(entry: temp)];
}

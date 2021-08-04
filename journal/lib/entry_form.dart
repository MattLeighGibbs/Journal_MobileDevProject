///
///
/// Will contain form widget for entering in journal entry
///
///

import 'package:flutter/material.dart';
import 'package:journal/database.dart';
import 'package:journal/models/journal_entry_model.dart';

class EntryForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final journalEntryModel = JournalEntryModel();
  final journalDatabase = JournalDatabase();

  EntryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Scaffold(
            body: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: 'Title', border: OutlineInputBorder()),
                        onSaved: (value) {
                          journalEntryModel.title = value;
                        },
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter a title';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: 'Body', border: OutlineInputBorder()),
                        onSaved: (value) {
                          journalEntryModel.body = value;
                        },
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter a Body';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: 'Rating', border: OutlineInputBorder()),
                        onSaved: (value) {
                          journalEntryModel.rating =
                              int.parse(value.toString());
                        },
                        validator: (value) {
                          if (value != '') {
                            return null;
                          } else {
                            return 'Please enter a Rating, and it has to be a number!';
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  journalEntryModel.date = DateTime.now();
                                  journalDatabase
                                      .insertEntry(journalEntryModel);
                                  formKey.currentState!.save();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text("Save Entry")),
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel")),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ]))));
  }
}

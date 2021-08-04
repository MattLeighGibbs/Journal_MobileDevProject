import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/journal_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class JournalDatabase {
  static final JournalDatabase _journalDatabase = JournalDatabase._internal();
  final String DB_PATH = 'journal.sqlite3.db';
  final String TABLE_NAME = 'journal_entries';

  JournalDatabase._internal();

  factory JournalDatabase() {
    return _journalDatabase;
  }
  Future<List<JournalEntryModel>> entries() async {
    // Get a reference to the database.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), DB_PATH),
    );
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      JournalEntryModel model = JournalEntryModel();
      model.id = maps[i]['id'];
      model.title = maps[i]['title'];
      model.body = maps[i]['body'];
      model.rating = maps[i]['rating'];
      model.date =
          DateTime.fromMillisecondsSinceEpoch(int.parse(maps[i]['date']));
      return model;
    });
  }

  Future<void> insertEntry(JournalEntryModel entry) async {
    // Get a reference to the database.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), DB_PATH),
    );

    final db = await database;
    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      TABLE_NAME,
      entry.toMap(),
    );
  }

  Future<void> rawSqlExecute(String sql) async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), DB_PATH),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(sql);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    await rootBundle.loadString('assets/schema_1.sql.txt').then((value) {
      rawSqlExecute(value);
      print(value);
    });
  }
}

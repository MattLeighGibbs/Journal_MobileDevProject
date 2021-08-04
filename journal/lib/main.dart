import 'package:flutter/material.dart';
import 'package:journal/main_journal_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:journal/database.dart';

JournalDatabase _database = JournalDatabase();

void main() async {
  await _database.initDB();
  runApp(new JournalApp());
}

class JournalApp extends StatefulWidget {
  const JournalApp({Key? key}) : super(key: key);

  @override
  _JournalAppState createState() => _JournalAppState();
}

class _JournalAppState extends State<JournalApp> {
  SharedPreferences? preferences;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    if (isDark) {
      return MaterialApp(
        title: 'Journal',
        home: new MainJournalWidget(callback: themeChanged),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          /* dark theme settings */
        ),
        themeMode: ThemeMode.dark,
      );
    } else {
      return MaterialApp(
        title: 'Journal',
        home: new MainJournalWidget(callback: themeChanged),
        theme: ThemeData(
          brightness: Brightness.light,
          /* light theme settings */
        ),
      );
    }
  }

  _loadApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    preferences = await SharedPreferences.getInstance();
    isDark = preferences!.getBool('isDark') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadApp();
  }

  themeChanged() {
    _loadApp();
    setState(() {});
  }
}

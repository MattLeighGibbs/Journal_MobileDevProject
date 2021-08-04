///
/// will contain the 'main page'.
/// wanted to separate this from the actual main file.
/// This should be the child of the scaffold or whatever is in main.
///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/database.dart';
import 'package:journal/entry_form.dart';
import 'package:journal/journal_entry_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/journal_entry_model.dart';

enum entryType { none, noEntries, entries }

class MainJournalWidget extends StatefulWidget {
  final Function callback;
  const MainJournalWidget({Key? key, required this.callback}) : super(key: key);

  @override
  _MainJournalWidgetState createState() => _MainJournalWidgetState(callback);
}

class _MainJournalWidgetState extends State<MainJournalWidget> {
  List<JournalEntryModel> _entries = [];
  JournalEntryModel _selectedEntry = JournalEntryModel();
  SharedPreferences? preferences;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  JournalDatabase database = JournalDatabase();

  _MainJournalWidgetState(this.callback);
  final Function callback;

  bool _darkMode = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getEntries();
  }

  getEntries() async {
    _entries = await database.entries();
    await initDrawerState();
    setState(() {});
  }

  initDrawerState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkMode = await prefs.getBool('isDark') ?? false;
    callback();
  }

  @override
  Widget build(BuildContext context) {
    if (_entries.isEmpty) {
      return noJournalEntriesPage();
    } else {
      return LayoutBuilder(builder: (context, dimensions) {
        if (dimensions.maxWidth >= 500) {
          return Row(children: <Widget>[
            Container(
                width: dimensions.maxWidth / 2,
                child: Scaffold(
                    body: buildJournalEntryList(() => horizontalOnTap()))),
            Container(
                width: dimensions.maxWidth / 2,
                child: _selectedEntry.title == null
                    ? horizontalDetailView()
                    : JournalEntryDetail(entry: _selectedEntry))
          ]);
        } else {
          return buildJournalEntryList(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        JournalEntryDetail(entry: _entries[_selectedIndex])));
          });
        }
      });
    }
  }

  List<Widget> settingsButton() {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        onPressed: () {
          _key.currentState?.openEndDrawer();
        },
      )
    ];
  }

  Widget noEntriesIcon() {
    return Center(
        child: Column(
      children: [
        Icon(
          Icons.note_alt_rounded,
          size: 100,
        ),
        Text("Journal")
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  Widget noJournalEntriesPage() {
    return Scaffold(
        appBar: AppBar(
            title: Text("Welcome"),
            centerTitle: true,
            actions: settingsButton()),
        body: noEntriesIcon(),
        key: _key,
        endDrawer: buildDrawer(),
        floatingActionButton: buildFloatingActionButton());
  }

  setTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _darkMode);
    callback();
  }

  buildFloatingActionButton() {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EntryForm()),
          ).then((value) {
            getEntries();
          });
        },
        child: Icon(Icons.add));
  }

  Widget buildJournalEntryList(onTapHandler) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: _key,
      endDrawer: buildDrawer(),
      appBar: AppBar(
        title: Text("Journal Entries"),
        centerTitle: true,
        actions: settingsButton(),
      ),
      body: buildListView(onTapHandler),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  sendToDetailView() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                JournalEntryDetail(entry: _entries[_selectedIndex])));
  }

  Widget buildListView(onTapHandler) {
    return ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          final _entry = _entries[index];
          return ListTile(
            title: Text(
              _entry.title!,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(_entry.dateToString()),
            onTap: () {
              _selectedIndex = index;
              onTapHandler();
            },
          );
        });
  }

  Widget buildDrawer() {
    return Drawer(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Theme"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Text("Dark Mode"),
                  SizedBox(width: 20),
                  CupertinoSwitch(
                    value: _darkMode,
                    onChanged: (bool value) {
                      _darkMode = value;
                      setState(() {
                        setTheme();
                      });
                    },
                  ),
                ],
              ),
            )));
  }

  horizontalDetailView() {
    return Scaffold(
        body: Center(
            child:
                Text("No Journal Selected", style: TextStyle(fontSize: 25))));
  }

  horizontalOnTap() {
    _selectedEntry = _entries[_selectedIndex];
    setState(() {});
  }
}

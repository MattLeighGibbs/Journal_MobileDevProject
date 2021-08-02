///
///
/// A model for a journal entry
///
///

class JournalEntryModel {
  DateTime date;
  String title;
  String body;
  int rating;
  int id;

  JournalEntryModel(
      {required this.body,
      required this.date,
      required this.id,
      required this.rating,
      required this.title});

  String dateToString() {
    return date.toString();
  }
}

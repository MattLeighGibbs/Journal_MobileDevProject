///
///
/// A model for a journal entry
///
///
///
import 'package:intl/intl.dart';

class JournalEntryModel {
  DateTime? date;
  String? title;
  String? body;
  int? rating;
  int? id;

  String dateToString() {
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    return formatter.format(date!);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'rating': rating,
      'date': date!.millisecondsSinceEpoch
    };
  }
}

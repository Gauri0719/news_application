import 'package:intl/intl.dart';

String formatToISTDate(String utcDate) {
  try {
    DateTime parsedDate = DateTime.parse(utcDate).toLocal(); // Convert UTC to Local
    DateFormat indianFormat = DateFormat('dd-MM-yyyy'); // Only date format
    return indianFormat.format(parsedDate);
  } catch (e) {
    return "Invalid Date";
  }
}

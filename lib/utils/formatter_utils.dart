import 'package:intl/intl.dart';

callDateTimeFormat(date) {
  String original = date;
  DateTime dateTime = DateTime.parse(original).toLocal();

  String formatted =
      DateFormat('dd MMM yyyy h:mma').format(dateTime).toLowerCase();

  return formatted;
}

extension StringCasingExtension on String {
  String get toCapitalized => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');
}
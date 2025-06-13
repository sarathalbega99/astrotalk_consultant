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

String formatDuration(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;
    final int secs = seconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours hr ${twoDigits(minutes)} mins ${twoDigits(secs)} secs';
    } else if (minutes > 0) {
      return '$minutes mins ${twoDigits(secs)} secs';
    } else {
      return '$secs secs';
    }
  }
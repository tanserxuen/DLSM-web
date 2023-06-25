
// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

class Util {
  static String formatYMD(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime.toLocal());
  }

  static String formatYMDHM(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime.toLocal());
  }

  static String formatHM(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime.toLocal());
  }
}
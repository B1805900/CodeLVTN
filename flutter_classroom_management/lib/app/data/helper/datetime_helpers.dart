import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelpers {
  static String timestampsToDate(Timestamp timestamp) {
    var datetime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat('dd-MM-yyyy').format(datetime);
  }

  static DateTime timestampsToDateTime(Timestamp timestamp) {
    return DateTime.fromMicrosecondsSinceEpoch(
        timestamp.microsecondsSinceEpoch);
  }

  static String timestampsToTime(Timestamp timestamp) {
    var datetime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat('HH:mm').format(datetime);
  }

  static String dateTimeToDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String dateTimeToTime(DateTime date) {
    return DateFormat('HH:mm').format(date).padLeft(2, '0');
  }

  static DateTime timeOfDayToDateTime(DateTime date, TimeOfDay time) {
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  static Timestamp dateTimeToTimestamp(DateTime datetime) {
    return Timestamp.fromDate(datetime);
  }

  static String dateTimeToDateOfWeek(DateTime datetime) {
    String dow = DateFormat('EEE').format(datetime);
    return dow;
  }

  static bool isBeforeNow(DateTime date) {
    final now = DateTime.now();
    return date.isBefore(now);
  }
}

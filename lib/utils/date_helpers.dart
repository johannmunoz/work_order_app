import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime fromDateJson(dynamic t) {
  if (t == null) {
    return DateTime.now();
  }
  if (t is Timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(t?.millisecondsSinceEpoch);
  } else if (t is String) {
    return DateTime.tryParse(t);
  } else {
    return DateTime.now();
  }
}

Timestamp toDateJson(DateTime time) {
  if (time == null) {
    time = DateTime.now();
  }
  return Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
}

TimeOfDay stringToTimeOfDay(String normTime) {
  DateTime date;
  if (normTime.toUpperCase().contains('PM') ||
      normTime.toUpperCase().contains('AM')) {
    date = DateFormat.jm().parse(normTime.toUpperCase());
  } else {
    date = DateFormat.Hm().parse(normTime.toUpperCase());
  }
  return TimeOfDay.fromDateTime(date);
}

String timeOfDayToString(TimeOfDay tod) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm();
  return format.format(dt);
}

DateTime addTimeToDateTime(DateTime date, String time) {
  TimeOfDay timeOfDay = stringToTimeOfDay(time);
  return DateTime(
      date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute);
}

DateTime getDateWithoutTime(DateTime selectedDate) {
  return DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
}

DateTime timeOfDayToDateTime(TimeOfDay timeOfDay, [DateTime dateTime]) {
  if (dateTime == null) {
    dateTime = DateTime.now();
  }
  return DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
}

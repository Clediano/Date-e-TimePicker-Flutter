import 'package:flutter/material.dart';

class Event {
  String name;
  String description;
  DateTime date;
  TimeOfDay time;

  String get getName => name;
  String get getDescription => description;
  DateTime get getDate => date;
  TimeOfDay get getHour => time;

  set setName(String name) => this.name = name;
  set setDescription(String description) => this.description = description;
  set setDate(DateTime date) => this.date = date;
  set setHour(TimeOfDay time) => this.time = time;

  Event({
    @required this.name,
    @required this.description,
    @required this.date,
    @required this.time,
  });
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventTile extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final String name;
  final String description;

  EventTile({
    @required this.date,
    @required this.time,
    @required this.name,
    @required this.description,
  });

  Widget _selectEventIcon() {
    DateTime today = DateTime.now();
    if (DateTime(
          date.year,
          date.month,
          date.day,
        ).compareTo(DateTime(
          today.year,
          today.month,
          today.day,
        )) ==
        0) {
      return Icon(Icons.event_available);
    } else {
      return Icon(Icons.event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(20),
      leading: _selectEventIcon(),
      title: Text(name),
      subtitle: Text(description),
      trailing: Text(
        '${DateFormat('dd/MM/yyyy').format(date)} - ${time.format(context)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

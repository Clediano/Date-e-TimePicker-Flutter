import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventForm extends StatefulWidget {
  final void Function(String, String, DateTime, TimeOfDay) onSubmit;

  EventForm(this.onSubmit);

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  _submitForm() {
    final name = _nameController.text;
    final description = _descriptionController.text;

    if (name.isEmpty ||
        description.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      return;
    }

    widget.onSubmit(name, description, _selectedDate, _selectedTime);
  }

  _showDatePicker() async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) => date.weekday == 6 ? false : true,
      initialDatePickerMode: DatePickerMode.day,
      locale: Locale('en')
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  _showTimePicker() async {
    TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _nameController,
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: _descriptionController,
              onSubmitted: (_) => _submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date selected!'
                          : 'Date selected: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Select date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'No time selected!'
                          : 'Time selected: ${_selectedTime.format(context)}',
                    ),
                  ),
                  FlatButton(
                    onPressed: _showTimePicker,
                    child: Text(
                      'Select time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add new event'),
                onPressed: _submitForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

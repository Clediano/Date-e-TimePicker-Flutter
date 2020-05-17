import 'package:datetimepicker/components/event_form.dart';
import 'package:datetimepicker/components/event_tile.dart';
import 'package:datetimepicker/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Exemple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Date & TimePickers'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt'),
        Locale('en', 'US'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Event> _events = [];

  _addEvent(String name, String description, DateTime date, TimeOfDay time) {
    final newEvent = Event(
      name: name,
      description: description,
      date: date,
      time: time,
    );

    setState(() {
      _events.add(newEvent);
    });

    Navigator.of(context).pop();
  }

  _openEventFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return EventForm(_addEvent);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _events.isEmpty
          ? Center(
              child: Text(
                'No events scheduled',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            )
          : ListView.builder(
              itemCount: _events.length,
              itemBuilder: (BuildContext context, int index) {
                Event event = _events[index];
                return EventTile(
                  name: event.name,
                  description: event.description,
                  date: event.date,
                  time: event.time,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEventFormModal(context),
        tooltip: 'Add new event',
        child: Icon(Icons.plus_one),
      ),
    );
  }
}

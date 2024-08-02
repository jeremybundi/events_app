import 'package:flutter/material.dart';
import 'screens/event_list_screen.dart';

void main() {
  runApp(EventBookingApp());
}

class EventBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventListScreen(),
    );
  }
}

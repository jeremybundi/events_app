import 'package:flutter/material.dart';
import '../models/event.dart';
import 'common_app_bar.dart';  

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  EventDetailsScreen({required this.event});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int ticketCount = 1; // Initial number of tickets

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Scaffold(
      appBar: CommonAppBar(),  // Use the CommonAppBar here
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display event image
            Image.network(
              event.imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Failed to load image'));
              },
            ),
            SizedBox(height: 10),
            Text(
              event.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Venue: ${event.venue}'),
            Text('Date: ${event.date}'),
            Text('Start Time: ${event.startTime}'),
            Text('End Time: ${event.endTime}'),
            SizedBox(height: 10),
            Text('Description:'),
            Text(event.description),
            SizedBox(height: 20),
            // Ticket count and adjustment controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tickets: $ticketCount',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (ticketCount > 1) ticketCount--;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          ticketCount++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

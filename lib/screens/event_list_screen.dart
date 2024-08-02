import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/event.dart';
import 'event_details_screen.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'common_app_bar.dart';  // Import the CommonAppBar
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<List<Event>> futureEvents;
  List<String> carouselImages = [];

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvents();
  }

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/event/get'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['data'];
        List<Event> events = jsonResponse.map((data) {
          return Event.fromJson(data);
        }).toList();

        // Extract all image URLs for the carousel from the events list
        carouselImages = events.map((event) => event.imageUrl).toList();

        return events;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error fetching events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),  
      body: FutureBuilder<List<Event>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load events'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events available'));
          } else {
            List<Event>? events = snapshot.data;

            return Column(
              children: [
                // Horizontal image carousel at the top
                Container(
                  height: 70,
                  width: double.infinity, 
                  child: CarouselSlider.builder(
                    itemCount: carouselImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = carouselImages[index];
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text('Failed to load image'));
                        },
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 16 / 4,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                    ),
                  ),
                ),
                // Event cards
                Expanded(
                  child: ListView.builder(
                    itemCount: events!.length,
                    itemBuilder: (context, index) {
                      return EventCard(event: events[index]);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              event.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Failed to load image'));
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(event.venue),
                SizedBox(height: 5),
                Text(event.date),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailsScreen(event: event),
                        ),
                      );
                    },
                    child: Text('Buy Ticket'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

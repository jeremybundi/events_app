import 'dart:convert';

class Event {
  final String id;
  final String name;
  final String date;
  final String startTime;
  final String endTime;
  final String venue;
  final String description;
  final String totalTickets;
  final String imageUrl; // Change from imageUrls to imageUrl for single image

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.venue,
    required this.description,
    required this.totalTickets,
    required this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      venue: json['venue'],
      description: json['description'],
      totalTickets: json['total_tickets'],
      imageUrl: json['image_url'], // Single image URL
    );
  }
}

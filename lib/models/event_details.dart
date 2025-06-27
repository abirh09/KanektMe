// To parse this JSON data, do
//
//     final eventDetails = eventDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EventDetails eventDetailsFromJson(String str) => EventDetails.fromJson(json.decode(str));

String eventDetailsToJson(EventDetails data) => json.encode(data.toJson());

class EventDetails {
  String name;
  String address;
  String contact;
  String time;

  EventDetails({
    required this.name,
    required this.address,
    required this.contact,
    required this.time,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) => EventDetails(
    name: json["name"],
    address: json["address"],
    contact: json["contact"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "contact": contact,
    "time": time,
  };
}

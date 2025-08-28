// To parse this JSON data, do
//
//     final restoListResponse = restoListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:resto_app/data/model/resto_brief.dart';

RestoListResponse restoListResponseFromJson(String str) =>
    RestoListResponse.fromJson(json.decode(str));

String restoListResponseToJson(RestoListResponse data) =>
    json.encode(data.toJson());

class RestoListResponse {
  final bool error;
  final String message;
  final int count;
  final List<RestoBrief> restaurants;

  RestoListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestoListResponse.fromJson(Map<String, dynamic> json) =>
      RestoListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestoBrief>.from(
          json["restaurants"].map((x) => RestoBrief.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

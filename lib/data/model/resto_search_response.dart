import 'dart:convert';

import 'package:resto_app/data/model/resto_brief.dart';

RestoSearchResponse restoSearchResponseFromJson(String str) =>
    RestoSearchResponse.fromJson(json.decode(str));

String restoSearchResponseToJson(RestoSearchResponse data) =>
    json.encode(data.toJson());

class RestoSearchResponse {
  final bool error;
  final int founded;
  final List<RestoBrief> restaurants;

  RestoSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestoSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestoSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestoBrief>.from(
          json["restaurants"].map((x) => RestoBrief.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

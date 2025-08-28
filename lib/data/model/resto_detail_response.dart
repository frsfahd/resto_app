// To parse this JSON data, do
//
//     final restoDetailResponse = restoDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:resto_app/data/model/resto_detail.dart';

RestoDetailResponse restoDetailResponseFromJson(String str) =>
    RestoDetailResponse.fromJson(json.decode(str));

String restoDetailResponseToJson(RestoDetailResponse data) =>
    json.encode(data.toJson());

class RestoDetailResponse {
  final bool error;
  final String message;
  final RestoDetail? restaurant;

  RestoDetailResponse({
    required this.error,
    required this.message,
    this.restaurant,
  });

  factory RestoDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestoDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: json["restaurant"] == null
            ? null
            : RestoDetail.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant!.toJson(),
  };
}

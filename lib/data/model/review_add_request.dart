// To parse this JSON data, do
//
//     final reviewAddRequest = reviewAddRequestFromJson(jsonString);

import 'dart:convert';

ReviewAddRequest reviewAddRequestFromJson(String str) =>
    ReviewAddRequest.fromJson(json.decode(str));

String reviewAddRequestToJson(ReviewAddRequest data) =>
    json.encode(data.toJson());

class ReviewAddRequest {
  final String id;
  final String name;
  final String review;

  ReviewAddRequest({
    required this.id,
    required this.name,
    required this.review,
  });

  factory ReviewAddRequest.fromJson(Map<String, dynamic> json) =>
      ReviewAddRequest(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "review": review};
}

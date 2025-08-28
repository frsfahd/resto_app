// To parse this JSON data, do
//
//     final reviewAddResponse = reviewAddResponseFromJson(jsonString);

import 'dart:convert';

import 'package:resto_app/data/model/customer_review.dart';

ReviewAddResponse reviewAddResponseFromJson(String str) =>
    ReviewAddResponse.fromJson(json.decode(str));

String reviewAddResponseToJson(ReviewAddResponse data) =>
    json.encode(data.toJson());

class ReviewAddResponse {
  final bool error;
  final String message;
  List<CustomerReview>? customerReviews;

  ReviewAddResponse({
    required this.error,
    required this.message,
    this.customerReviews,
  });

  factory ReviewAddResponse.fromJson(Map<String, dynamic> json) =>
      ReviewAddResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(
                json["customerReviews"]!.map((x) => CustomerReview.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews": customerReviews == null
        ? []
        : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
  };
}

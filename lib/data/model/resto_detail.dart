import 'package:resto_app/data/model/customer_review.dart';

class RestoDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category>? categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  RestoDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestoDetail.fromJson(Map<String, dynamic> json) => RestoDetail(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    address: json["address"],
    pictureId: json["pictureId"],
    categories: json["categories"] == null
        ? []
        : List<Category>.from(
            json["categories"]!.map((x) => Category.fromJson(x)),
          ),
    menus: json["menus"] == null
        ? Menus(foods: [], drinks: [])
        : Menus.fromJson(json["menus"]),
    rating: json["rating"].toDouble(),
    customerReviews: json["customerReviews"] == null
        ? []
        : List<CustomerReview>.from(
            json["customerReviews"]!.map((x) => CustomerReview.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "menus": menus.toJson(),
    "rating": rating,
    "customerReviews": List<dynamic>.from(
      customerReviews.map((x) => x.toJson()),
    ),
  };
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}

class Menus {
  final List<Category> foods;
  final List<Category> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: json["foods"] == null
        ? []
        : List<Category>.from(json["foods"]!.map((x) => Category.fromJson(x))),
    drinks: json["drinks"] == null
        ? []
        : List<Category>.from(json["drinks"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}

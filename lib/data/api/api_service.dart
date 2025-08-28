import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:resto_app/data/model/resto_detail_response.dart';
import 'package:resto_app/data/model/resto_list_response.dart';
import 'package:resto_app/data/model/resto_search_response.dart';
import 'package:resto_app/data/model/review_add_request.dart';
import 'package:resto_app/data/model/review_add_response.dart';

class ApiService {
  static const String _baseurl = "https://restaurant-api.dicoding.dev";

  Future<RestoListResponse> getRestoList() async {
    try {
      final Response = await http.get(Uri.parse("$_baseurl/list"));

      if (Response.statusCode == 200) {
        return restoListResponseFromJson(Response.body);
      }

      throw ("Failed to load resto list");
    } catch (e) {
      if (e is SocketException) {
        throw ('No Internet Connection. Please try again later.');
      } else if (e is TimeoutException) {
        throw ('Request timed out. Please try again later.');
      } else if (e is FormatException) {
        throw ('Failed to load response data.');
      } else {
        throw ("Caught an error: $e");
      }
    }
  }

  Future<RestoDetailResponse> getRestoDetail(String restoID) async {
    try {
      final response = await http.get(Uri.parse("$_baseurl/detail/$restoID"));

      if (response.statusCode == 200) {
        return restoDetailResponseFromJson(response.body);
      }

      throw ("Failed to load resto detail");
    } catch (e) {
      if (e is SocketException) {
        throw ('No Internet Connection. Please try again later.');
      } else if (e is TimeoutException) {
        throw ('Request timed out. Please try again later.');
      } else if (e is FormatException) {
        throw ('Failed to load response data.');
      } else {
        throw ("Caught an error: $e");
      }
    }
  }

  Future<RestoSearchResponse> searchRestoList(String query) async {
    try {
      final response = await http.get(Uri.parse("$_baseurl/search?q=$query"));

      if (response.statusCode == 200) {
        return restoSearchResponseFromJson(response.body);
      }

      throw ("Failed to load search result");
    } catch (e) {
      if (e is SocketException) {
        throw ('No Internet Connection. Please try again later.');
      } else if (e is TimeoutException) {
        throw ('Request timed out. Please try again later.');
      } else if (e is FormatException) {
        throw ('Failed to load response data.');
      } else {
        throw ("Caught an error: $e");
      }
    }
  }

  Future<ReviewAddResponse> addReview(ReviewAddRequest review) async {
    final reviewData = reviewAddRequestToJson(review);

    try {
      final response = await http.post(
        Uri.parse("$_baseurl/review"),
        body: reviewData,
        headers: {"content-type": "application/json"},
      );

      if (response.statusCode == 201) {
        return reviewAddResponseFromJson(response.body);
      }
      throw ("Failed to post a review");
    } catch (e) {
      if (e is SocketException) {
        throw ('No Internet Connection. Please try again later.');
      } else if (e is TimeoutException) {
        throw ('Request timed out. Please try again later.');
      } else if (e is FormatException) {
        throw ('Failed to load response data.');
      } else {
        throw ("Caught an error: $e");
      }
    }
  }
}

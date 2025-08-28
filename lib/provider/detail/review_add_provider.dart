import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/review_add_request.dart';
import 'package:resto_app/static/review_add_result_state.dart';

class ReviewAddProvider extends ChangeNotifier {
  final ApiService _apiService;
  ReviewAddProvider(this._apiService);

  ReviewAddResultState _resultState = ReviewAddNoneState();
  ReviewAddResultState get resultState => _resultState;

  void resetState() {
    _resultState = ReviewAddNoneState();
  }

  Future<void> addReview(ReviewAddRequest reviewData) async {
    try {
      _resultState = ReviewAddLoadingState();
      notifyListeners();

      final result = await _apiService.addReview(reviewData);
      if (result.error) {
        _resultState = ReviewAddErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = ReviewAddLoadedState(result.customerReviews!);
        notifyListeners();
      }
    } catch (e) {
      _resultState = ReviewAddErrorState(e.toString());
      notifyListeners();
    }
  }
}

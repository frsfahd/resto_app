import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/static/resto_search_result_state.dart';

class RestoSearchProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestoSearchProvider(this._apiService);

  RestoSearchResultState _resultState = RestoSearchNoneState();
  RestoSearchResultState get resultState => _resultState;

  void reset() {
    _resultState = RestoSearchNoneState();
    notifyListeners();
  }

  Future<void> searchResto(String query) async {
    try {
      _resultState = RestoSearchLoadingState();
      notifyListeners();

      final result = await _apiService.searchRestoList(query);

      if (result.error) {
        _resultState = RestoSearchErrorState("Error Unknown");
        notifyListeners();
      } else if (result.founded != 0) {
        _resultState = RestoSearchLoadedState(result.restaurants);
        notifyListeners();
      } else {
        _resultState = RestoSearchLoadedState([]);
        notifyListeners();
      }
    } catch (e) {
      _resultState = RestoSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}

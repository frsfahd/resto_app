import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/static/resto_detail_result_state.dart';

class RestoDetailProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestoDetailProvider(this._apiService);

  RestoDetailResultState _resultState = RestoDetailNoneState();
  RestoDetailResultState get resultState => _resultState;

  Future<void> fetchRestoDetail(String restoID) async {
    try {
      _resultState = RestoDetailLoadingState();
      notifyListeners();

      final result = await _apiService.getRestoDetail(restoID);

      if (result.error) {
        _resultState = RestoDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestoDetailLoadedState(result.restaurant!);
        notifyListeners();
      }
    } catch (e) {
      _resultState = RestoDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:resto_app/data/local/local_database_service.dart';
import 'package:resto_app/data/model/resto_brief.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<RestoBrief>? _restoList;
  List<RestoBrief>? get restoList => _restoList;

  RestoBrief? _resto;
  RestoBrief? get resto => _resto;

  Future<void> saveResto(RestoBrief value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
      } else {
        _message = "Your data is saved";
      }
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> loadAllResto() async {
    try {
      _restoList = await _service.getAllItems();
      _resto = null;
      _message = "All of your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data";
      notifyListeners();
    }
  }

  Future<void> loadRestoById(String id) async {
    try {
      _resto = await _service.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> removeRestoById(String id) async {
    try {
      await _service.removeItem(id);

      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  bool checkItemBookmark(String id) {
    final isSameResto = _resto?.id == id;
    return isSameResto;
  }
}

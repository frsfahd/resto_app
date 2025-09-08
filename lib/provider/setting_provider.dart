import 'package:flutter/material.dart';
import 'package:resto_app/data/local/shared_preferences_service.dart';
import 'package:resto_app/data/model/setting.dart';

class SettingProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  Setting? _setting;
  Setting? get setting => _setting;

  SettingProvider(this._service) {
    getSettingValue();
  }

  String _message = "";
  String get message => _message;

  ThemeMode get themeMode =>
      _setting!.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> saveSettingValue(Setting value) async {
    try {
      await _service.saveSettingValue(value);
      _message = "Your data is saved";
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  void getSettingValue() async {
    try {
      _setting = _service.getSettingValue();
      _message = "Data successfully retrieved";
    } catch (e) {
      _message = "Failed to get your data";
    }
    notifyListeners();
  }

  void toggleTheme() {
    _setting?.isDarkMode = !_setting!.isDarkMode;
    saveSettingValue(_setting!);
    notifyListeners();
  }
}

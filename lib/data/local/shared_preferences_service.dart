import 'package:resto_app/data/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const _keyTheme = "DARK_THEME";
  static const _keyNotif = "LUNCH_REMAINDER";

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _preferences.setBool(_keyTheme, setting.isDarkMode);
      await _preferences.setBool(_keyNotif, setting.isLunchNotif);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  Setting getSettingValue() {
    return Setting(
      isDarkMode: _preferences.getBool(_keyTheme) ?? false,
      isLunchNotif: _preferences.getBool(_keyNotif) ?? false,
    );
  }
}

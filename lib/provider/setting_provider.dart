import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resto_app/data/local/local_notification_service.dart';
import 'package:resto_app/data/local/shared_preferences_service.dart';
import 'package:resto_app/data/model/setting.dart';

class SettingProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  final LocalNotificationService flutterNotificationService;

  Setting? _setting;
  Setting? get setting => _setting;

  SettingProvider(this._service, this.flutterNotificationService) {
    getSettingValue();
  }

  String _message = "";
  String get message => _message;

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  bool get isNotifShow => _setting!.isLunchNotif;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

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

  Future<void> toggleNotification() async {
    _setting!.isLunchNotif = !_setting!.isLunchNotif;
    if (isNotifShow) {
      if (permission != true) {
        await requestPermissions();
      }

      // showNotification();
      scheduleDailyElevenAMNotification();
    } else {
      cancelNotification(_notificationId);
    }
    saveSettingValue(_setting!);
    notifyListeners();
  }

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification() {
    _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "Lunch Remainder",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }

  void scheduleDailyElevenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyElevenAMNotification(
      id: _notificationId,
    );
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests = await flutterNotificationService
        .pendingNotificationRequests();
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
  }
}

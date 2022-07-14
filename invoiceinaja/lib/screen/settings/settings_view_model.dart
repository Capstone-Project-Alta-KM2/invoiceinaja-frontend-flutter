import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SettingViewState {
  none,
  loading,
  noConnection,
  serverTimeout,
  error,
}

class SettingViewModel with ChangeNotifier {
  SettingViewState _state = SettingViewState.none;
  SettingViewState get state => _state;

  changeState(SettingViewState l) {
    _state = l;
    notifyListeners();
  }

  Future logout() async {
    changeState(SettingViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await prefs.remove('email');
      await prefs.remove('avatar');
      await prefs.remove('token');
      changeState(SettingViewState.none);
    } catch (e) {
      changeState(SettingViewState.error);
    }
  }
}

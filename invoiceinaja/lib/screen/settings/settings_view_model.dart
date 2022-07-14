import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/api/api_client.dart';

enum SettingViewState {
  none,
  loading,
  noConnection,
  serverTimeout,
  error,
  tokenExpired,
}

class SettingViewModel with ChangeNotifier {
  SettingViewState _state = SettingViewState.none;
  SettingViewState get state => _state;

  UserModel _userData = UserModel();
  UserModel get userData => _userData;

  changeState(SettingViewState l) {
    _state = l;
    notifyListeners();
  }

  Future getDataUser() async {
    changeState(SettingViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? id = prefs.getString('id');
      String? nama = prefs.getString('nama');
      String? company = prefs.getString('company');
      String? phone = prefs.getString('phone');
      String? email = prefs.getString('email');
      String? avatar = prefs.getString('avatar');
      String? password = prefs.getString('password');
      String? token = prefs.getString('token');
      final dataApi = UserModel(
        id: int.parse(id!),
        fullname: nama,
        company: company,
        avatar: avatar,
        email: email,
        phoneNumber: phone,
        password: password,
        token: token,
      );
      print(nama);
      print(token);
      print(avatar);
      _userData = dataApi;

      notifyListeners();
      changeState(SettingViewState.none);
    } catch (e) {
      if (e.toString().contains('Token Expired')) {
        changeState(SettingViewState.tokenExpired);
      } else {
        changeState(SettingViewState.error);
      }
      print(e);
    }
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

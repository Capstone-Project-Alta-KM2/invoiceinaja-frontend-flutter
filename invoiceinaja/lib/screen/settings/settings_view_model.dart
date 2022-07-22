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
  failed,
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
    // changeState(SettingViewState.loading);
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
      _userData = dataApi;

      notifyListeners();
      changeState(SettingViewState.none);
    } catch (e) {
      if (e.toString().contains('Token Expired')) {
        changeState(SettingViewState.tokenExpired);
      } else {
        changeState(SettingViewState.error);
      }
    }
  }

  Future updateUser(UserModel user) async {
    changeState(SettingViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      await ApiClient().updateUser(user, token!);
      prefs.setString('nama', user.fullname.toString());
      prefs.setString('company', user.company.toString());
      prefs.setString('phone', user.phoneNumber.toString());
      prefs.setString('email', user.email.toString());
      changeState(SettingViewState.none);
    } catch (e) {
      if (e.toString().contains('No Connection in Your Phone')) {
        changeState(SettingViewState.noConnection);
      } else if (e.toString().contains('Connection Timeout to Server')) {
        changeState(SettingViewState.serverTimeout);
      } else if (e.toString().contains('Update Gagal')) {
        changeState(SettingViewState.failed);
      } else {
        changeState(SettingViewState.error);
      }
    }
  }

  Future changePassword(String oldPassword, String newPassword) async {
    changeState(SettingViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      await ApiClient().changePassword(oldPassword, newPassword, token!);
      changeState(SettingViewState.none);
    } catch (e) {
      if (e.toString().contains('No Connection in Your Phone')) {
        changeState(SettingViewState.noConnection);
      } else if (e.toString().contains('Connection Timeout to Server')) {
        changeState(SettingViewState.serverTimeout);
      } else if (e.toString().contains('Ganti Password Gagal')) {
        changeState(SettingViewState.failed);
      } else {
        changeState(SettingViewState.error);
      }
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

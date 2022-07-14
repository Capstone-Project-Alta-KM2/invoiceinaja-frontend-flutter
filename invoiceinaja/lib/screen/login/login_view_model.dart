import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/api/api_client.dart';

enum LoginViewState {
  none,
  loading,
  noConnection,
  serverTimeout,
  failed,
  error,
}

class LoginViewModel with ChangeNotifier {
  LoginViewState _state = LoginViewState.none;
  LoginViewState get state => _state;

  changeState(LoginViewState l) {
    _state = l;
    notifyListeners();
  }

  Future login(String email, String password) async {
    changeState(LoginViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await ApiClient().login(email, password).then((value) {
        prefs.setString('id', value.id.toString());
        prefs.setString('nama', value.fullname.toString());
        prefs.setString('company', value.company.toString());
        prefs.setString('phone', value.phoneNumber.toString());
        prefs.setString('email', value.email.toString());
        prefs.setString('avatar', value.avatar.toString());
        prefs.setString('password', value.password.toString());
        prefs.setString('token', value.token.toString());

        return value;
      });

      changeState(LoginViewState.none);
    } catch (e) {
      if (e.toString().contains('No Connection in Your Phone')) {
        changeState(LoginViewState.noConnection);
      } else if (e.toString().contains('Connection Timeout to Server')) {
        changeState(LoginViewState.serverTimeout);
      } else if (e.toString().contains('Login Gagal')) {
        changeState(LoginViewState.failed);
      } else {
        changeState(LoginViewState.error);
      }

      print(e);
    }
  }
}

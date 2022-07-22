import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/remember_model.dart';
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
  bool _isRemember = false;
  bool get isRemember => _isRemember;
  set isRememberModel(bool isRememberNew) {
    _isRemember = isRememberNew;
    notifyListeners();
  }

  RememberModel _rememberModel = RememberModel(email: '', password: '');
  RememberModel get rememberModel => _rememberModel;

  changeState(LoginViewState l) {
    _state = l;
    notifyListeners();
  }

  Future getData() async {
    changeState(LoginViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? email = prefs.getString('emailLogin');
      String? password = prefs.getString('passwordLogin');
      final dataRemember = RememberModel(email: email!, password: password!);
      _rememberModel = dataRemember;
      changeState(LoginViewState.none);
    } catch (e) {
      changeState(LoginViewState.error);
    }
  }

  Future login(String email, String password) async {
    changeState(LoginViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (isRemember == true) {
        prefs.setBool('remember', isRemember);
        prefs.setString('emailLogin', email);
        prefs.setString('passwordLogin', password);
      }
      if (isRemember == false) {
        await prefs.remove('remember');
        await prefs.remove('emailLogin');
        await prefs.remove('passwordLogin');
      }
      await ApiClient().login(email, password).then((value) {
        prefs.setString('id', value.id.toString());
        prefs.setString('nama', value.fullname.toString());
        prefs.setString('company', value.company.toString());
        prefs.setString('phone', value.phoneNumber.toString());
        prefs.setString('email', value.email.toString());
        prefs.setString('avatar', 'http://103.176.78.214:8080/${value.avatar}');
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
    }
  }

  Future resetPassword(String email) async {
    changeState(LoginViewState.loading);

    try {
      await ApiClient().resetPassword(email);
      changeState(LoginViewState.none);
    } catch (e) {
      if (e.toString().contains('Connection Timeout to Server')) {
        changeState(LoginViewState.serverTimeout);
      } else {
        changeState(LoginViewState.error);
      }
    }
  }
}

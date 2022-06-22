import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/api/login_api.dart';

enum LoginViewState {
  none,
  loading,
  error,
}

class LoginViewModel with ChangeNotifier {
  LoginViewState _state = LoginViewState.none;
  LoginViewState get state => _state;

  changeState(LoginViewState l) {
    _state = l;
    notifyListeners();
  }

  void login(String email, String password) async {
    changeState(LoginViewState.loading);

    try {
      await LoginApi().login(email, password);
      changeState(LoginViewState.none);
    } catch (e) {
      changeState(LoginViewState.error);
    }
  }
}

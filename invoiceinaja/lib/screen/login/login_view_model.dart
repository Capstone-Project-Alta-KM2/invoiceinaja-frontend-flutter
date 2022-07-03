import 'package:flutter/material.dart';

import '../../model/api/api_client.dart';

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
      await ApiClient().login(email, password).then((value) => print(value));
      changeState(LoginViewState.none);
    } catch (e) {
      changeState(LoginViewState.error);
      print(e);
    }
  }
}

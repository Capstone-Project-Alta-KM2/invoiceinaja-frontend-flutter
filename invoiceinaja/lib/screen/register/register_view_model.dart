import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/user_model.dart';

import '../../model/api/api_client.dart';

enum RegisterViewState {
  none,
  loading,
  noConnection,
  serverTimeout,
  failed,
  error,
}

class RegisterViewModel with ChangeNotifier {
  RegisterViewState _state = RegisterViewState.none;
  RegisterViewState get state => _state;

  changeState(RegisterViewState l) {
    _state = l;
    notifyListeners();
  }

  Future register(UserModel user) async {
    changeState(RegisterViewState.loading);

    try {
      await ApiClient().register(user);
      changeState(RegisterViewState.none);
    } catch (e) {
      if (e.toString().contains('No Connection in Your Phone')) {
        changeState(RegisterViewState.noConnection);
      } else if (e.toString().contains('Connection Timeout to Server')) {
        changeState(RegisterViewState.serverTimeout);
      } else if (e.toString().contains('Register Gagal')) {
        changeState(RegisterViewState.failed);
      } else {
        changeState(RegisterViewState.error);
      }
      print(e);
    }
  }
}

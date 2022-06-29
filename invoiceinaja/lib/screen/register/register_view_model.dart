import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/user_model.dart';

import '../../model/api/api_client.dart';

enum RegisterViewState {
  none,
  loading,
  error,
}

class RegisterViewModel with ChangeNotifier {
  RegisterViewState _state = RegisterViewState.none;
  RegisterViewState get state => _state;

  changeState(RegisterViewState l) {
    _state = l;
    notifyListeners();
  }

  void register(UserModel user) async {
    changeState(RegisterViewState.loading);

    try {
      await ApiClient().register(user).then((value) => print(value));
      changeState(RegisterViewState.none);
    } catch (e) {
      changeState(RegisterViewState.error);
      print(e);
    }
  }
}

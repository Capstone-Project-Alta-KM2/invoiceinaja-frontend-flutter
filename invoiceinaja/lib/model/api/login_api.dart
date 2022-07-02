import 'dart:convert';

import 'package:dio/dio.dart';

class LoginApi {
  Future<Response> login(String email, String password) async {
    try {
      final response = await Dio().post(
        'http://103.176.78.214:8080/api/v1/sessions',
        data: {
          'email': email,
          'kata_sandi': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

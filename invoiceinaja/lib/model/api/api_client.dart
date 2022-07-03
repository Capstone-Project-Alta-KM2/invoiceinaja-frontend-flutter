import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:invoiceinaja/model/user_model.dart';

class ApiClient {
  var dio = Dio();

  ApiClient() {
    BaseOptions options = BaseOptions(
        baseUrl: 'http://103.176.78.214:8080/api/v1',
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000 // 60 seconds
        );

    dio = Dio(options);
  }

  Future<Response> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/sessions',
        data: {
          'email': email,
          'password': password,
        },
      );

      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> register(UserModel user) async {
    try {
      final response = await dio.post(
        '/users',
        data: jsonEncode(user.toJson()),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}

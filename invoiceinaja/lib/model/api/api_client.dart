import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:invoiceinaja/model/login_model.dart';
import 'package:invoiceinaja/model/user_model.dart';

import '../client_model.dart';
import '../invoice_model.dart';

class ApiClient {
  var dio = Dio();

  ApiClient() {
    BaseOptions options = BaseOptions(
        baseUrl: 'http://103.176.78.214:8080/api/v1',
        receiveDataWhenStatusError: true,
        connectTimeout: 3 * 1000, // 60 seconds
        receiveTimeout: 3 * 1000 // 60 seconds
        );

    dio = Dio(options);
  }

  Future<LoginModel> login(String email, String password) async {
    try {
      Response response = await dio.post(
        '/sessions',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 201) {
        return LoginModel.fromJson(response.data);
      } else {
        return throw Exception('Login Gagal');
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Login Gagal');
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
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Register Gagal');
      }
      throw Exception(e.message);
    }
  }

  Future<List<InvoiceModel>> getDataInvoice(String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response<List<dynamic>> response = await dio.get('/invoices');
      List<InvoiceModel>? listData = response.data
          ?.map((invoice) => InvoiceModel.fromJson(invoice))
          .toList();
      return listData ?? [];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Gagal Memuat Data');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> addInvoice(InvoiceModel invoice, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.post(
        '/invoices',
        data: jsonEncode(invoice.toJson()),
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Add data invoice failed');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> updateInvoice(
      InvoiceModel invoice, String id, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.put(
        '/invoices/$id',
        data: jsonEncode(invoice.toJson()),
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Update data invoice failed');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> deleteInvoice(String id, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.delete(
        '/invoices/$id',
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Delete Invoice failed');
      }
      throw Exception(e.message);
    }
  }

  Future<List<ClientModel>> getDataClient(String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response<List<dynamic>> response = await dio.get('/clients');
      List<ClientModel>? listData =
          response.data?.map((client) => ClientModel.fromJson(client)).toList();
      return listData ?? [];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Gagal Memuat Data');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> addClient(ClientModel client, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.post(
        '/clients',
        data: jsonEncode(client.toJson()),
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Add data invoice failed');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> updateClient(
      ClientModel client, String id, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.put(
        '/invoices/$id',
        data: jsonEncode(client.toJson()),
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Update data invoice failed');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> deleteClient(String id, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.delete(
        '/clients/$id',
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Delete Invoice failed');
      }
      throw Exception(e.message);
    }
  }
}

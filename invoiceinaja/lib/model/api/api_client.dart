import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:invoiceinaja/model/login_model.dart';
import 'package:invoiceinaja/model/overall_model.dart';
import 'package:invoiceinaja/model/post_invoice_model.dart';
import 'package:invoiceinaja/model/user_model.dart';

import '../client_model.dart';
import '../graphics_model.dart';
import '../invoice_model.dart';
import '../invoices_model.dart';

class ApiClient {
  var dio = Dio();

  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://103.176.78.214:8080/api/v1',
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
    );

    dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<UserModel> login(String email, String password) async {
    try {
      Response response = await dio.post(
        '/sessions',
        data: {
          'email': email,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
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
      if (e.response?.statusCode == 400) {
        throw Exception('Register Gagal');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> updateUser(UserModel user, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.put(
        '/users',
        data: jsonEncode(user.toJson()),
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Update User Gagal');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> changePassword(
      String oldPassword, String newPassword, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response response = await dio.post(
        '/change_passwords',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Ganti Password Gagal');
      }
      throw Exception(e.message);
    }
  }

  Future<List<InvoiceModel>> getDataInvoice(String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response response = await dio.get('/invoices');
      List<dynamic> listClient = response.data['data'];
      List<InvoiceModel> listData =
          listClient.map((invoice) => InvoiceModel.fromJson(invoice)).toList();
      return listData;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Gagal Memuat Data');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> addInvoice(PostInvoice invoice, String token) async {
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
      if (e.response?.statusCode == 400) {
        throw Exception('Add data invoice failed');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  // Future<Response> updateInvoice(
  //     InvoiceModel invoice, String id, String token) async {
  //   try {
  //     dio.options.headers["Authorization"] = 'Bearer $token';
  //     final response = await dio.put(
  //       '/invoices/$id',
  //       data: jsonEncode(invoice.toJson()),
  //     );
  //     return response;
  //   } on DioError catch (e) {
  //     if (e.type == DioErrorType.connectTimeout) {
  //       throw Exception('Connection Timeout to Server');
  //     }
  //     if (e.response?.statusCode == 422) {
  //       throw Exception('Update data invoice failed');
  //     }
  //     if (e.response?.statusCode == 401) {
  //       throw Exception('Token Expired');
  //     }
  //     throw Exception(e.message);
  //   }
  // }

  Future<Response> deleteInvoice(int id, String token) async {
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
      if (e.response?.statusCode == 400) {
        throw Exception('Delete Invoice failed');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<List<ClientModel>> getDataClient(String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response response = await dio.get('/clients');
      List<dynamic> listClient = response.data['data'];
      List<ClientModel> listData =
          listClient.map((client) => ClientModel.fromJson(client)).toList();
      return listData;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Gagal Memuat Data');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
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
      if (e.response?.statusCode == 400) {
        throw Exception('Add data invoice failed');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> updateClient(
      ClientModel client, int id, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.put(
        '/clients/$id',
        data: jsonEncode(client.toJson()),
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Update data client failed');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> deleteClient(int id, String token) async {
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
      if (e.response?.statusCode == 400) {
        throw Exception('Delete client failed');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<List<Payment>> getDataGraphic(String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response response = await dio.get('/graphics');
      Map<String, dynamic> responseData = response.data['data'];
      List<dynamic> listClient = [];
      responseData.forEach((key, value) {
        listClient.add(value);
      });

      List<Payment> listData =
          listClient.map((client) => Payment.fromJson(client)).toList();

      return listData;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Gagal Memuat Data');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<OverallModel> getDataOverall(String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response response = await dio.get('/overall');
      var overall = response.data['data'];

      return OverallModel.fromJson(overall);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Gagal Memuat Data');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<UserModel> getDataUser(String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response response = await dio.get('/users');
      var user = response.data['data'];

      return UserModel.fromJson(user);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Gagal Memuat Data');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<List<InvoicesModel>> getDataInvoiceActivities(String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      Response response = await dio.get('/clients');
      List<dynamic> listClient = response.data['data'];
      List<InvoicesModel> listData =
          listClient.map((client) => InvoicesModel.fromJson(client)).toList();
      return listData;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 400) {
        throw Exception('Gagal Memuat Data');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }

  Future<Response> addInvoicesActivities(
      InvoicesModel activities, String token) async {
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      final response = await dio.post(
        '/clients',
        data: jsonEncode(activities.toJson()),
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout to Server');
      }
      if (e.response?.statusCode == 422) {
        throw Exception('Add data invoice failed');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Token Expired');
      }
      throw Exception(e.message);
    }
  }
}

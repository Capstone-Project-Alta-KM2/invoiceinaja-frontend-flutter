import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoiceinaja/model/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/Firebase/firestore_client.dart';
import '../../model/client_model.dart';
import '../../model/recent_activities_model.dart';

enum ClientViewState {
  none,
  loading,
  error,
  tokenExpired,
}

class ClientsViewModel extends ChangeNotifier {
  ClientViewState _state = ClientViewState.none;
  ClientViewState get state => _state;

  bool _isSearching = false;
  bool get isSearching => _isSearching;
  set isSearchingModel(bool isSearch) {
    _isSearching = isSearch;
    notifyListeners();
  }

  var _listClients = <ClientModel>[];
  List<ClientModel> get listClient => List.unmodifiable(_listClients);

  var _listDataClients = <ClientModel>[];
  List<ClientModel> get listDataClient => List.unmodifiable(_listDataClients);
  set listDataClientModel(List<ClientModel> listDataClientModel) {
    _listDataClients = listDataClientModel;
    notifyListeners();
  }

  changeState(ClientViewState s) {
    _state = s;
    notifyListeners();
  }

  Future deleteClient(int index) async {
    changeState(ClientViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      String? id = prefs.getString('id');
      await ApiClient().deleteClient(index, token!).then((_) {
        FireStoreService().saveRecent(RecentActivitiesModel(
          createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          dateSort: DateTime.now().microsecondsSinceEpoch,
          idInvoice: index,
          message: 'Client has been deleted',
          userId: int.parse(id!),
        ));
      });
      getData();
      notifyListeners();
      changeState(ClientViewState.none);
    } catch (e) {
      changeState(ClientViewState.error);
    }
  }

  Future addClient(ClientModel client) async {
    changeState(ClientViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      String? id = prefs.getString('id');
      await ApiClient().addClient(client, token!).then((value) {
        FireStoreService().saveRecent(RecentActivitiesModel(
          createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          dateSort: DateTime.now().microsecondsSinceEpoch,
          idInvoice: value.id,
          message: 'New client created',
          userId: int.parse(id!),
        ));
      });
      notifyListeners();
      changeState(ClientViewState.none);
    } catch (e) {
      changeState(ClientViewState.error);
    }
  }

  Future updateClient(ClientModel client, int id) async {
    changeState(ClientViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      await ApiClient().updateClient(client, id, token!);
      notifyListeners();
      changeState(ClientViewState.none);
    } catch (e) {
      changeState(ClientViewState.error);
    }
  }

  Future getData() async {
    changeState(ClientViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      final dataApi = await ApiClient().getDataClient(token!);
      _listClients = dataApi;
      notifyListeners();
      changeState(ClientViewState.none);
    } catch (e) {
      if (e.toString().contains('Token Expired')) {
        changeState(ClientViewState.tokenExpired);
      } else {
        changeState(ClientViewState.error);
      }
    }
  }

  Future logout() async {
    changeState(ClientViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await prefs.remove('email');
      await prefs.remove('avatar');
      await prefs.remove('token');
      changeState(ClientViewState.none);
    } catch (e) {
      changeState(ClientViewState.error);
    }
  }
}

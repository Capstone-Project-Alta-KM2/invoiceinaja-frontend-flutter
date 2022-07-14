import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/client_model.dart';

enum ClientViewState {
  none,
  loading,
  error,
  tokenExpired,
}

class ClientsViewModel with ChangeNotifier {
  ClientViewState _state = ClientViewState.none;
  ClientViewState get state => _state;
  var _listClients = <ClientModel>[];
  List<ClientModel> get listClient => List.unmodifiable(_listClients);
  // InvoiceModel _dataId = InvoiceModel();
  // InvoiceModel get dataId => _dataId;

  changeState(ClientViewState s) {
    _state = s;
    notifyListeners();
  }

  Future deleteClient(int index) async {
    changeState(ClientViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      await ApiClient().deleteClient(index, token!);
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
      await ApiClient().addClient(client, token!).then((value) => print(value));
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

    // List<String>? listKontak = sharedPrefs.getStringList('contact');
    // if (listKontak != null) {
    //   _contactModels = [
    //     ...listKontak
    //         .map((contact) => ContactsModel.fromMap(jsonDecode(contact)))
    //         .toList()
    //   ];
    // }
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
  // getDataId(String id) async {
  //   changeState(InvoiceViewState.loading);

  //   try {
  //     final dataContact = await ApiClient().getDataContactsID(id);
  //     _dataId = dataContact;
  //     notifyListeners();
  //     changeState(InvoiceViewState.none);
  //   } catch (e) {
  //     changeState(InvoiceViewState.error);
  //   }
  // }

  // saveDatatoPreferences() {
  //   List<String> data =
  //       _listInvoices.map((contact) => jsonEncode(contact.toMap())).toList();
  //   sharedPrefs.setStringList('contact', data);
  //   notifyListeners();
  // }
}

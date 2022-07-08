import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/api/api_client.dart';

import '../../model/client_model.dart';

enum ClientViewState {
  none,
  loading,
  error,
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

  deleteClient(String index) async {
    changeState(ClientViewState.loading);
    try {
      await ApiClient().deleteClient(index);
      getData();
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
      changeState(ClientViewState.none);
    } catch (e) {
      changeState(ClientViewState.error);
    }
  }

  Future addClient(ClientModel client) async {
    changeState(ClientViewState.loading);
    try {
      await ApiClient().addClient(client);

      changeState(ClientViewState.none);
    } catch (e) {
      changeState(ClientViewState.error);
      print(e);
    }
  }

  Future updateClient(ClientModel client, String id) async {
    changeState(ClientViewState.loading);
    try {
      await ApiClient().updateClient(client, id);
      notifyListeners();
      changeState(ClientViewState.none);
    } catch (e) {
      changeState(ClientViewState.error);
    }
  }

  getData() async {
    changeState(ClientViewState.loading);

    try {
      final dataApi = await ApiClient().getDataClient();
      _listClients = dataApi;
      notifyListeners();
      changeState(ClientViewState.none);
    } catch (e) {
      changeState(ClientViewState.error);
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

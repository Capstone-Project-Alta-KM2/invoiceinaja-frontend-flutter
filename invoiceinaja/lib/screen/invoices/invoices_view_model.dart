import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/invoice_model.dart';

enum InvoiceViewState {
  none,
  loading,
  error,
}

class InvoicesViewModel with ChangeNotifier {
  InvoiceViewState _state = InvoiceViewState.none;
  InvoiceViewState get state => _state;
  List<InvoiceModel> _listInvoices = <InvoiceModel>[];
  List<InvoiceModel> get listInvoice => List.unmodifiable(_listInvoices);
  List<List<InvoiceModel>> _listAllInvoices = [];
  List<List<InvoiceModel>> get listAllInvoice =>
      List.unmodifiable(_listAllInvoices);
  // InvoiceModel _dataId = InvoiceModel();
  // InvoiceModel get dataId => _dataId;
  final List<String> _dataTitle = [
    'All',
    'Paid',
    'Unpaid',
    'Draft',
    'Overdue',
  ];

  List<String> get listTitle => List.unmodifiable(_dataTitle);

  changeState(InvoiceViewState s) {
    _state = s;
    notifyListeners();
  }

  Future deleteInvoice(String index) async {
    changeState(InvoiceViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      await ApiClient().deleteInvoice(index, token!);
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
    }
  }

  addInvoice(InvoiceModel invoice) async {
    changeState(InvoiceViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      await ApiClient().addInvoice(invoice, token!);
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
    }
  }

  updateInvoice(InvoiceModel invoice, String id) async {
    changeState(InvoiceViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      await ApiClient().updateInvoice(invoice, id, token!);
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
    }
  }

  Future getData() async {
    changeState(InvoiceViewState.loading);
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      final dataApi = await ApiClient().getDataInvoice(token!);
      _listInvoices = dataApi;
      _listAllInvoices = [
        _listInvoices,

        _listInvoices.where((element) => element.status == 'PAID').toList(),

        _listInvoices.where((element) => element.status == 'UNPAID').toList(),

        _listInvoices.where((element) => element.status == 'DRAFT').toList(),

        _listInvoices.where((element) => element.status == 'OVERDUE').toList(),

        // [
        //   InvoiceModel(
        //       amount: 20000,
        //       client: 'Ferdi',
        //       status: 'PAID',
        //       postDue: '26-07-2022')
        // ],
        // [],
        // [],
        // [],
        // [],
      ];
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
      print(e);
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

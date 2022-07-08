import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/api/api_client.dart';

import '../../model/invoice_model.dart';

enum InvoiceViewState {
  none,
  loading,
  error,
}

class InvoicesViewModel with ChangeNotifier {
  InvoiceViewState _state = InvoiceViewState.none;
  InvoiceViewState get state => _state;
  var _listInvoices = <InvoiceModel>[];
  List<InvoiceModel> get listInvoice => List.unmodifiable(_listInvoices);
  var _listAllInvoices = [];
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
    try {
      await ApiClient().deleteInvoice(index);
      getData();
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
    }
  }

  addInvoice(InvoiceModel invoice) async {
    await ApiClient().addInvoice(invoice);
    getData();
    notifyListeners();
  }

  updateInvoice(InvoiceModel invoice, String id) async {
    await ApiClient().updateInvoice(invoice, id);
    getData();
    notifyListeners();
  }

  getData() async {
    changeState(InvoiceViewState.loading);

    try {
      final dataApi = await ApiClient().getDataInvoice();
      _listInvoices = dataApi;
      _listAllInvoices = [
        _listInvoices,
        _listInvoices.where((element) => element.status == 'PAID').toList(),
        _listInvoices.where((element) => element.status == 'UNPAID').toList(),
        _listInvoices.where((element) => element.status == 'DRAFT').toList(),
        _listInvoices.where((element) => element.status == 'OVERDUE').toList(),
      ];
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
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

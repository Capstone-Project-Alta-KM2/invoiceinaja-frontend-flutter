import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoiceinaja/model/Firebase/firestore_client.dart';
import 'package:invoiceinaja/model/api/api_client.dart';
import 'package:invoiceinaja/model/client_model.dart';
import 'package:invoiceinaja/model/post_invoice_model.dart';
import 'package:invoiceinaja/model/recent_activities_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/invoice_model.dart';

enum InvoiceViewState {
  none,
  loading,
  error,
  tokenExpired,
}

class InvoicesViewModel with ChangeNotifier {
  InvoiceViewState _state = InvoiceViewState.none;
  InvoiceViewState get state => _state;
  final List<DetailInvoice> _listItems = <DetailInvoice>[];
  List<DetailInvoice> get listItems => _listItems;
  List<ClientModel> _listClients = <ClientModel>[];
  List<ClientModel> get listClients => List.unmodifiable(_listClients);
  List<InvoiceModel> _listInvoices = <InvoiceModel>[];
  List<InvoiceModel> get listInvoice => List.unmodifiable(_listInvoices);
  List<List<InvoiceModel>> _listAllInvoices = [];
  List<List<InvoiceModel>> get listAllInvoice =>
      List.unmodifiable(_listAllInvoices);
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

  Future deleteInvoice(int index) async {
    changeState(InvoiceViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      String? id = prefs.getString('id');
      await ApiClient().deleteInvoice(index, token!).then((_) {
        FireStoreService().saveRecent(RecentActivitiesModel(
          createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          dateSort: DateTime.now().microsecondsSinceEpoch,
          idInvoice: index,
          message: 'Invoice has been deleted',
          userId: int.parse(id!),
        ));
      });
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
    }
  }

  Future addInvoice(PostInvoice invoice) async {
    changeState(InvoiceViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      String? id = prefs.getString('id');
      await ApiClient().addInvoice(invoice, token!).then((value) {
        FireStoreService().saveRecent(RecentActivitiesModel(
          createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          dateSort: DateTime.now().microsecondsSinceEpoch,
          idInvoice: value.id,
          message: 'New invoice created',
          userId: int.parse(id!),
        ));
      });
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
    }
  }

  Future getData() async {
    changeState(InvoiceViewState.loading);
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
      ];
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      if (e.toString().contains('Token Expired')) {
        changeState(InvoiceViewState.tokenExpired);
      } else {
        changeState(InvoiceViewState.error);
      }
    }
  }

  Future getDataClient() async {
    _listClients.clear();
    changeState(InvoiceViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      final dataApi = await ApiClient().getDataClient(token!);
      _listClients = dataApi;
      notifyListeners();
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
    }
  }

  void addItems(DetailInvoice detailInvoice) {
    _listItems.add(detailInvoice);
    notifyListeners();
  }

  Future logout() async {
    changeState(InvoiceViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await prefs.remove('email');
      await prefs.remove('avatar');
      await prefs.remove('token');
      changeState(InvoiceViewState.none);
    } catch (e) {
      changeState(InvoiceViewState.error);
    }
  }
}

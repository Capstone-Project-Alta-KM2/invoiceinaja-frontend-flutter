import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/api/api_client.dart';
import 'package:invoiceinaja/model/invoices_model.dart';
import 'package:invoiceinaja/model/overall_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/chart_model.dart';
import '../../model/graphics_model.dart';

enum DashBoardViewState {
  none,
  loading,
  error,
  tokenExpired,
}

class DashBoardsViewModel with ChangeNotifier {
  DashBoardViewState _state = DashBoardViewState.none;
  DashBoardViewState get state => _state;
  OverallModel _overallData = OverallModel(
    customer: 0,
    paid: 0,
    unpaid: 0,
  );
  OverallModel get overallData => _overallData;
  var _listGraphic = <Payment>[];
  List<Payment> get listGraphic => List.unmodifiable(_listGraphic);
  var _listChart = <ChartModel>[];
  List<ChartModel> get listChart => List.unmodifiable(_listChart);
  var _listInvoiceActivities = <InvoicesModel>[];
  List<InvoicesModel> get listInvoiceActivities =>
      List.unmodifiable(_listInvoiceActivities);

  changeState(DashBoardViewState s) {
    _state = s;
    notifyListeners();
  }

  Future getDataOverall() async {
    changeState(DashBoardViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      final dataApi = await ApiClient().getDataOverall(token!);
      _overallData = dataApi;
      notifyListeners();
      changeState(DashBoardViewState.none);
    } catch (e) {
      if (e.toString().contains('Token Expired')) {
        changeState(DashBoardViewState.tokenExpired);
      } else {
        changeState(DashBoardViewState.error);
      }
    }
  }

  Future getDataGraphic() async {
    changeState(DashBoardViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      final dataApi = await ApiClient().getDataGraphic(token!);
      _listGraphic = dataApi;
      _listChart = List.generate(
        _listGraphic.length,
        (index) => ChartModel(
          x: index,
          y1: _listGraphic[index].paid!.toDouble(),
          y2: _listGraphic[index].unpaid!.toDouble(),
        ),
      );
      notifyListeners();
      changeState(DashBoardViewState.none);
    } catch (e) {
      if (e.toString().contains('Token Expired')) {
        changeState(DashBoardViewState.tokenExpired);
      } else {
        changeState(DashBoardViewState.error);
        print(e);
      }
    }
  }

  Future getDataActivities() async {
    changeState(DashBoardViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      final dataApi = await ApiClient().getDataInvoiceActivities(token!);
      _listInvoiceActivities = dataApi;
      notifyListeners();
      changeState(DashBoardViewState.none);
    } catch (e) {
      if (e.toString().contains('Token Expired')) {
        changeState(DashBoardViewState.tokenExpired);
      } else {
        changeState(DashBoardViewState.error);
      }
    }
  }

  Future logout() async {
    changeState(DashBoardViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await prefs.remove('email');
      await prefs.remove('avatar');
      await prefs.remove('token');
      changeState(DashBoardViewState.none);
    } catch (e) {
      changeState(DashBoardViewState.error);
    }
  }
}

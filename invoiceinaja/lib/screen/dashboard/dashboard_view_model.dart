import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/Firebase/firestore_client.dart';
import 'package:invoiceinaja/model/api/api_client.dart';
import 'package:invoiceinaja/model/overall_model.dart';
import 'package:invoiceinaja/model/recent_activities_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/chart_model.dart';
import '../../model/graphics_model.dart';
import '../../model/invoice_model.dart';

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
  var _listInvoiceActivities = <InvoiceModel>[];
  List<InvoiceModel> get listInvoiceActivities =>
      List.unmodifiable(_listInvoiceActivities);
  var _listRecent = <RecentActivitiesModel>[];
  List<RecentActivitiesModel> get listRecent => List.unmodifiable(_listRecent);
  var _listToday = <RecentActivitiesModel>[];
  List<RecentActivitiesModel> get listToday => List.unmodifiable(_listToday);
  var _listYesterday = <RecentActivitiesModel>[];
  List<RecentActivitiesModel> get listYesterday =>
      List.unmodifiable(_listYesterday);
  var _listLater = <RecentActivitiesModel>[];
  List<RecentActivitiesModel> get listLater => List.unmodifiable(_listLater);

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
      _listChart = List.generate(_listGraphic.length, (index) {
        final data = _listGraphic[index];
        return ChartModel(
          x: index,
          y1: data.paid!.toDouble(),
          y2: data.unpaid!.toDouble(),
        );
      });
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

  Future getDataActivities() async {
    changeState(DashBoardViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('token');
      final dataApi = await ApiClient().getDataInvoice(token!);
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

  Future getDataNotifications() async {
    changeState(DashBoardViewState.loading);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? id = prefs.getString('id');
      final dataFirestore =
          await FireStoreService().getRecentActivities(int.parse(id!));
      _listRecent = dataFirestore;
      _listToday = _listRecent
          .where((element) =>
              DateTime.now()
                  .difference(DateTime.parse(element.createdAt!))
                  .inDays ==
              0)
          .toList();
      _listYesterday = _listRecent
          .where((element) =>
              DateTime.now()
                  .difference(DateTime.parse(element.createdAt!))
                  .inDays ==
              1)
          .toList();
      _listLater = _listRecent
          .where((element) =>
              DateTime.now()
                  .difference(DateTime.parse(element.createdAt!))
                  .inDays >
              1)
          .toList();
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

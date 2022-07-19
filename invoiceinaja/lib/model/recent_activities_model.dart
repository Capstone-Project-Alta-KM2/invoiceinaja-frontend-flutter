class RecentActivitiesModel {
  String? createdAt;
  int? dateSort;
  int? idInvoice;
  String? message;
  int? userId;

  RecentActivitiesModel(
      {this.createdAt,
      this.dateSort,
      this.idInvoice,
      this.message,
      this.userId});

  RecentActivitiesModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    dateSort = json['date_sort'];
    idInvoice = json['id_invoice'];
    message = json['message'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['date_sort'] = dateSort;
    data['id_invoice'] = idInvoice;
    data['message'] = message;
    data['user_id'] = userId;
    return data;
  }
}

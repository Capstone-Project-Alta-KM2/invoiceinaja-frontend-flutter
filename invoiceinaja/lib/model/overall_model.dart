class OverallModel {
  int? paid;
  int? unpaid;
  int? customer;

  OverallModel({this.paid, this.unpaid, this.customer});

  OverallModel.fromJson(Map<String, dynamic> json) {
    paid = json['paid'];
    unpaid = json['unpaid'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paid'] = paid;
    data['unpaid'] = unpaid;
    data['customer'] = customer;
    return data;
  }
}

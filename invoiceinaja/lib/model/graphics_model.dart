class GraphicModel {
  Payment? jan;
  Payment? feb;
  Payment? mar;
  Payment? apr;
  Payment? may;
  Payment? jun;
  Payment? jul;
  Payment? agt;
  Payment? sep;
  Payment? okt;
  Payment? nov;
  Payment? des;

  GraphicModel(
      {this.jan,
      this.feb,
      this.mar,
      this.apr,
      this.may,
      this.jun,
      this.jul,
      this.agt,
      this.sep,
      this.okt,
      this.nov,
      this.des});

  GraphicModel.fromJson(Map<String, dynamic> json) {
    jan = json['Jan'] != null ? Payment.fromJson(json['Jan']) : null;
    feb = json['Feb'] != null ? Payment.fromJson(json['Feb']) : null;
    mar = json['Mar'] != null ? Payment.fromJson(json['Mar']) : null;
    apr = json['Apr'] != null ? Payment.fromJson(json['Apr']) : null;
    may = json['May'] != null ? Payment.fromJson(json['May']) : null;
    jun = json['Jun'] != null ? Payment.fromJson(json['Jun']) : null;
    jul = json['Jul'] != null ? Payment.fromJson(json['Jul']) : null;
    agt = json['Agt'] != null ? Payment.fromJson(json['Agt']) : null;
    sep = json['Sep'] != null ? Payment.fromJson(json['Sep']) : null;
    okt = json['Okt'] != null ? Payment.fromJson(json['Okt']) : null;
    nov = json['Nov'] != null ? Payment.fromJson(json['Nov']) : null;
    des = json['Des'] != null ? Payment.fromJson(json['Des']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jan != null) {
      data['Jan'] = jan!.toJson();
    }
    if (feb != null) {
      data['Feb'] = feb!.toJson();
    }
    if (mar != null) {
      data['Mar'] = mar!.toJson();
    }
    if (apr != null) {
      data['Apr'] = apr!.toJson();
    }
    if (may != null) {
      data['May'] = may!.toJson();
    }
    if (jun != null) {
      data['Jun'] = jun!.toJson();
    }
    if (jul != null) {
      data['Jul'] = jul!.toJson();
    }
    if (agt != null) {
      data['Agt'] = agt!.toJson();
    }
    if (sep != null) {
      data['Sep'] = sep!.toJson();
    }
    if (okt != null) {
      data['Okt'] = okt!.toJson();
    }
    if (nov != null) {
      data['Nov'] = nov!.toJson();
    }
    if (des != null) {
      data['Des'] = des!.toJson();
    }
    return data;
  }
}

class Payment {
  int? paid;
  int? unpaid;

  Payment({this.paid, this.unpaid});

  Payment.fromJson(Map<String, dynamic> json) {
    paid = json['paid'];
    unpaid = json['unpaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paid'] = paid;
    data['unpaid'] = unpaid;
    return data;
  }
}

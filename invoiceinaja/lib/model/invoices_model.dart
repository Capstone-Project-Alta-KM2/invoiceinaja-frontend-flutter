class InvoicesModel {
  String? namaclient;
  String? tanggalinvoices;
  String? totalinvoices;
  String? statuspembayaran;

  InvoicesModel(
      {this.namaclient,
      this.tanggalinvoices,
      this.totalinvoices,
      this.statuspembayaran});

  InvoicesModel.fromJson(Map<String, dynamic> json) {
    namaclient = json['namaclient'];
    tanggalinvoices = json['tanggalinvoices'];
    totalinvoices = json['totalinvoices'];
    statuspembayaran = json['statuspembayaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['namaclient'] = namaclient;
    data['tanggalinvoices'] = tanggalinvoices;
    data['totalinvoices'] = totalinvoices;
    data['statuspembayaran'] = statuspembayaran;
    return data;
  }
}

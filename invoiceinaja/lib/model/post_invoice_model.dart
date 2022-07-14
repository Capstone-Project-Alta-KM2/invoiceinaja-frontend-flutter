class PostInvoice {
  Invoice? invoice;
  List<DetailInvoice>? detailInvoice;

  PostInvoice({this.invoice, this.detailInvoice});

  PostInvoice.fromJson(Map<String, dynamic> json) {
    invoice =
        json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null;
    if (json['detail_invoice'] != null) {
      detailInvoice = <DetailInvoice>[];
      json['detail_invoice'].forEach((v) {
        detailInvoice!.add(DetailInvoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (invoice != null) {
      data['invoice'] = invoice!.toJson();
    }
    if (detailInvoice != null) {
      data['detail_invoice'] = detailInvoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoice {
  int? clientId;
  int? totalAmount;
  String? invoiceDate;
  String? invoiceDue;

  Invoice({this.clientId, this.totalAmount, this.invoiceDate, this.invoiceDue});

  Invoice.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    totalAmount = json['total_amount'];
    invoiceDate = json['invoice_date'];
    invoiceDue = json['invoice_due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['total_amount'] = totalAmount;
    data['invoice_date'] = invoiceDate;
    data['invoice_due'] = invoiceDue;
    return data;
  }
}

class DetailInvoice {
  String? itemName;
  int? price;
  int? quantity;

  DetailInvoice({this.itemName, this.price, this.quantity});

  DetailInvoice.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}

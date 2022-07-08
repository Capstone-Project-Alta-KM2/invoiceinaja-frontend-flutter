class InvoiceModel {
  int? id;
  String? client;
  String? date;
  String? postDue;
  int? amount;
  String? status;
  List<Items>? items;

  InvoiceModel(
      {this.id,
      this.client,
      this.date,
      this.postDue,
      this.amount,
      this.status,
      this.items});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    date = json['date'];
    postDue = json['post_due'];
    amount = json['Amount'];
    status = json['status'];
    if (json['Items'] != null) {
      items = <Items>[];
      json['Items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client'] = client;
    data['date'] = date;
    data['post_due'] = postDue;
    data['Amount'] = amount;
    data['status'] = status;
    if (items != null) {
      data['Items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? itemName;
  int? price;
  int? quantity;
  int? total;

  Items({this.itemName, this.price, this.quantity, this.total});

  Items.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['price'] = price;
    data['quantity'] = quantity;
    data['total'] = total;
    return data;
  }
}

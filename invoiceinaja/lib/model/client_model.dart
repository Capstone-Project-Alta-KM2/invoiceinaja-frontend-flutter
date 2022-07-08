class ClientModel {
  int? id;
  String? fullname;
  String? email;
  String? address;
  String? city;
  String? zipCode;
  String? company;

  ClientModel(
      {this.id,
      this.fullname,
      this.email,
      this.address,
      this.city,
      this.zipCode,
      this.company});

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    zipCode = json['zip_code'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['address'] = address;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['company'] = company;
    return data;
  }
}

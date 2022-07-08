class UserModel {
  String? namaLengkap;
  String? email;
  String? namaBisnis;
  String? noTlp;
  String? kataSandi;

  UserModel({
    this.namaLengkap,
    this.email,
    this.noTlp,
    this.namaBisnis,
    this.kataSandi,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    namaLengkap = json['fullname'];
    email = json['email'];
    noTlp = json['phone_number'];
    namaBisnis = json['company'];
    kataSandi = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = namaLengkap;
    data['email'] = email;
    data['phone_number'] = noTlp;
    data['company'] = namaBisnis;
    data['password'] = kataSandi;
    return data;
  }
}

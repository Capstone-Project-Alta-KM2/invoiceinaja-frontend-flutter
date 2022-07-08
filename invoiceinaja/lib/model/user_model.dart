class UserModel {
  String? namaLengkap;
  String? email;
  String? namaBisnis;
  String? kataSandi;

  UserModel({this.namaLengkap, this.email, this.namaBisnis, this.kataSandi});

  UserModel.fromJson(Map<String, dynamic> json) {
    namaLengkap = json['nama_lengkap'];
    email = json['email'];
    namaBisnis = json['nama_bisnis'];
    kataSandi = json['kata_sandi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_lengkap'] = namaLengkap;
    data['email'] = email;
    data['nama_bisnis'] = namaBisnis;
    data['kata_sandi'] = kataSandi;
    return data;
  }
}

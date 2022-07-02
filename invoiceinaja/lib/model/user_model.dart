class UserModel {
  String? namaLengkap;
  String? email;
  String? noTlpn;
  String? namaBisnis;
  String? kataSandi;

  UserModel(
      {this.namaLengkap,
      this.email,
      this.noTlpn,
      this.namaBisnis,
      this.kataSandi});

  UserModel.fromJson(Map<String, dynamic> json) {
    namaLengkap = json['nama_lengkap'];
    email = json['email'];
    noTlpn = json['no_tlpn'];
    namaBisnis = json['nama_bisnis'];
    kataSandi = json['kata_sandi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_lengkap'] = this.namaLengkap;
    data['email'] = this.email;
    data['no_tlpn'] = this.noTlpn;
    data['nama_bisnis'] = this.namaBisnis;
    data['kata_sandi'] = this.kataSandi;
    return data;
  }
}

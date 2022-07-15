class UserModel {
  int? id;
  String? fullname;
  String? email;
  String? phoneNumber;
  String? company;
  String? password;
  String? avatar;
  String? token;

  UserModel(
      {this.id,
      this.fullname,
      this.email,
      this.phoneNumber,
      this.company,
      this.password,
      this.avatar,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    company = json['company'];
    password = json['password'];
    avatar = json['avatar'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['company'] = company;
    data['password'] = password;
    data['avatar'] = avatar;
    data['token'] = token;
    return data;
  }
}

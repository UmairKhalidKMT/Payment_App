class UserModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String address;
  String status;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.status,
  });
}

class Rigister_user {
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? phone;
  String? email;
  String? address;
  int? status;
  int? subgroupId;
  int? roleId;

  Rigister_user(
      {this.firstName,
        this.lastName,
        this.username,
        this.password,
        this.phone,
        this.email,
        this.address,
        this.status,
        this.subgroupId,
        this.roleId});

  Rigister_user.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    status = json['status'];
    subgroupId = json['subgroup_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['status'] = this.status;
    data['subgroup_id'] = this.subgroupId;
    data['role_id'] = this.roleId;
    return data;
  }
}


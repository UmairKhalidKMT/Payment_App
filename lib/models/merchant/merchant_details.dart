class merchants_list {
  String? message;
  List<Data>? data;

  merchants_list({this.message, this.data});

  merchants_list.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? merchantId;
  String? name;
  int? subgroupId;
  String? phone;
  String? email;
  String? businessName;
  String? address;
  int? status;
  String? createdAt;
  String? updatedAt;
  Subgroup? subgroup;

  Data(
      {this.merchantId,
        this.name,
        this.subgroupId,
        this.phone,
        this.email,
        this.businessName,
        this.address,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.subgroup});

  Data.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchant_id'];
    name = json['name'];
    subgroupId = json['subgroup_id'];
    phone = json['phone'];
    email = json['email'];
    businessName = json['business_name'];
    address = json['address'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    subgroup = json['subgroup'] != null
        ? new Subgroup.fromJson(json['subgroup'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_id'] = this.merchantId;
    data['name'] = this.name;
    data['subgroup_id'] = this.subgroupId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['business_name'] = this.businessName;
    data['address'] = this.address;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.subgroup != null) {
      data['subgroup'] = this.subgroup!.toJson();
    }
    return data;
  }
}

class Subgroup {
  String? subgroupName;

  Subgroup({this.subgroupName});

  Subgroup.fromJson(Map<String, dynamic> json) {
    subgroupName = json['subgroup_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subgroup_name'] = this.subgroupName;
    return data;
  }
}

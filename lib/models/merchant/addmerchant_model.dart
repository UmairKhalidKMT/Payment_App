class addmerchants {
  String? name;
  String? phone;
  String? email;
  String? businessName;
  int? status;
  String? address;
  int? subgroupId;

  addmerchants(
      {this.name,
        this.phone,
        this.email,
        this.businessName,
        this.status,
        this.address,
        this.subgroupId});

  addmerchants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    businessName = json['business_name'];
    status = json['status'];
    address = json['address'];
    subgroupId = json['subgroup_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['business_name'] = this.businessName;
    data['status'] = this.status;
    data['address'] = this.address;
    data['subgroup_id'] = this.subgroupId;
    return data;
  }
}

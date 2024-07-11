class ShadulofCharges {
  int? chargesId;
  String? name;
  String? rangeamount;
  String? percentage;
  String? fixedamount;
  int? merchantId;
  int? status;
  String? createdAt;
  String? updatedAt;

  ShadulofCharges(
      {this.chargesId,
        this.name,
        this.rangeamount,
        this.percentage,
        this.fixedamount,
        this.merchantId,
        this.status,
        this.createdAt,
        this.updatedAt});

  ShadulofCharges.fromJson(Map<String, dynamic> json) {
    chargesId = json['charges_id'];
    name = json['name'];
    rangeamount = json['rangeamount'];
    percentage = json['percentage'];
    fixedamount = json['fixedamount'];
    merchantId = json['merchant_id'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charges_id'] = this.chargesId;
    data['name'] = this.name;
    data['rangeamount'] = this.rangeamount;
    data['percentage'] = this.percentage;
    data['fixedamount'] = this.fixedamount;
    data['merchant_id'] = this.merchantId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
  static List<ShadulofCharges> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ShadulofCharges.fromJson(json)).toList();
  }
}

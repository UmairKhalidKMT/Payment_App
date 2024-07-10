class addShadulofCharges {
  String? name;
  String? rangeamount;
  String? percentage;
  String? fixedamount;
  int? status;
  int? merchantId;

  addShadulofCharges(
      {this.name,
        this.rangeamount,
        this.percentage,
        this.fixedamount,
        this.status,
        this.merchantId});

  addShadulofCharges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rangeamount = json['rangeamount'];
    percentage = json['percentage'];
    fixedamount = json['fixedamount'];
    status = json['status'];
    merchantId = json['merchant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rangeamount'] = this.rangeamount;
    data['percentage'] = this.percentage;
    data['fixedamount'] = this.fixedamount;
    data['status'] = this.status;
    data['merchant_id'] = this.merchantId;
    return data;
  }
}

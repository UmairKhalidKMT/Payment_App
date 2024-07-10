
class addDevices {
  String? terminalSn;
  String? productKey;
  String? location;
  String? status;
  int? merchantId;

  addDevices(
      {this.terminalSn,
        this.productKey,
        this.location,
        this.status,
        this.merchantId});

  addDevices.fromJson(Map<String, dynamic> json) {
    terminalSn = json['terminal_sn'];
    productKey = json['product_key'];
    location = json['location'];
    status = json['status'];
    merchantId = json['merchant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terminal_sn'] = this.terminalSn;
    data['product_key'] = this.productKey;
    data['location'] = this.location;
    data['status'] = this.status;
    data['merchant_id'] = this.merchantId;
    return data;
  }
}

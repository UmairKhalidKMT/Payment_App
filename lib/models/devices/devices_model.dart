class Devices {
  int? terminalId;
  String? terminalSn;
  String? productKey;
  String? location;
  int? merchantId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Devices({
    this.terminalId,
    this.terminalSn,
    this.productKey,
    this.location,
    this.merchantId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Devices.fromJson(Map<String, dynamic> json) {
    terminalId = json['terminal_id'];
    terminalSn = json['terminal_sn'];
    productKey = json['product_key'];
    location = json['location'];
    merchantId = json['merchant_id'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  static List<Devices> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Devices.fromJson(json)).toList();
  }
}

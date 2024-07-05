class ScheduleChargesModel {
  String name;
  String range;
  String percentage;
  String fixedCharges;
  String merchantId;
  String status;

  ScheduleChargesModel({
    required this.name,
    required this.range,
    required this.percentage,
    required this.fixedCharges,
    required this.merchantId,
    required this.status,
  });
}

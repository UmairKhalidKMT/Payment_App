import 'package:flutter/material.dart';
import 'package:payment_app/models/schedule_of_charges/schedule_charges.dart';

class ScheduleChargesController extends ChangeNotifier {
  List<ScheduleChargesModel> scheduleCharges = [];

  void addCharge(ScheduleChargesModel charges) {
    scheduleCharges.add(charges);
    notifyListeners();
  }

  void updateCharge(int index, ScheduleChargesModel charges) {
    scheduleCharges[index] = charges;
    notifyListeners();
  }

  void deleteCharge(int index) {
    scheduleCharges.removeAt(index);
    notifyListeners();
  }
}

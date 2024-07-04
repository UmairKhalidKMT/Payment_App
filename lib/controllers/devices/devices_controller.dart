import 'package:flutter/material.dart';
import 'package:payment_app/models/devices/devices_model.dart';

class DevicesController extends ChangeNotifier {
  List<Devices> devices = [];

  void addDevice(Devices device) {
    devices.add(device);
    notifyListeners();
  }

  void updateDevice(int index, Devices device) {
    devices[index] = device;
    notifyListeners();
  }

  void deleteDevice(int index) {
    devices.removeAt(index);
    notifyListeners;
  }
}

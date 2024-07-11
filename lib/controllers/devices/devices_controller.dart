import 'package:flutter/material.dart';
import 'package:payment_app/Repository/Devices_repository.dart';
import 'package:payment_app/models/devices/addDevice_model.dart';
import 'package:payment_app/models/devices/devices_model.dart';

class DevicesController extends ChangeNotifier {
  List<Devices> devices = [];
  List<addDevices> _adddevice=[];

  //............................get devices..................................................

  Future<void> fetchingdevices() async {
    try {
      var result = await device_repository().fetchingdevices();
      print('get Device details: $result');

      // Assuming result is a JSON list
      devices = Devices.fromJsonList(result) as List<Devices>;

      devices.forEach((device) {
        print(device.productKey);
      });

      notifyListeners();
    } catch (e) {
      print('Error fetching devices: $e');
    }
  }


  //..................................... create device.........................................................
  Future createdevice(
      String terminal_sn,
      String product_key,
      String location,
      String status,
      String merchant_id,

      )async{
    try {
      var update1=await device_repository().Adddevice(
        terminal_sn,
        product_key,
        location,
        status,
        merchant_id, );
      print('profile update ${update1.merchantId}');
      if(update1.terminalSn!=null){
        _adddevice.add(_adddevice as addDevices);

      }


    } catch (e) {
      print("error $e");

    }
  }

  //..............................delete the device.........................................................

  Future<void> deletedevice(String id) async {
    var result = await device_repository().Deletedevice(id);
    // print('get Brand details: $result');
    //
    // getmerchant=merchants_list.fromJson(result);
    // getmerchant!.data!.forEach((element) {
    //   print(element.name);
    // });
    notifyListeners();
  }

  //..................................... update device.........................................................
  Future updatedevice(
      String terminal_sn,
      String product_key,
      String location,
      String status,
      String merchant_id,
      String deviceid

      )async{
    try {
      var update1=await device_repository().updatedevice(
        terminal_sn,
        product_key,
        location,
        status,
        merchant_id,
      deviceid);
      print('profile update ${update1.merchantId}');
      if(update1.terminalSn!=null){
        _adddevice.add(_adddevice as addDevices);

      }


    } catch (e) {
      print("error $e");

    }
  }






// void addDevice(Devices device) {
  //   devices.add(device);
  //   notifyListeners();
  // }
  //
  // void updateDevice(int index, Devices device) {
  //   devices[index] = device;
  //   notifyListeners();
  // }
  //
  // void deleteDevice(int index) {
  //   devices.removeAt(index);
  //   notifyListeners();
  // }
}

import 'package:flutter/material.dart';
import 'package:payment_app/Repository/ShadulOfCharges_repository.dart';
import 'package:payment_app/models/schedule_of_charges/addScheduleOfCharges_modee.dart';
import 'package:payment_app/models/schedule_of_charges/schedule_charges.dart';

class ScheduleChargesController extends ChangeNotifier {
  List<ShadulofCharges> scheduleCharges = [];
  List<addShadulofCharges> _addcharges=[];


  //............................get Schedule of charges..................................................

  Future<void> fetchingChrges() async {
    try {
      var result = await ShadulofchargesRepository().fetchingCharges();
      print('get Device details: $result');

      // Assuming result is a JSON list
      scheduleCharges = ShadulofCharges.fromJsonList(result) as List<ShadulofCharges>;

      scheduleCharges.forEach((device) {
        print(device.name);
      });

      notifyListeners();
    } catch (e) {
      print('Error fetching devices: $e');
    }
  }


  //..................................... create Schedule of charges.........................................................
  Future createSchedulOfCharges(
      String name,
      String rangeamount,
      String percentage,
      String fixedamount,
      String status,
      String merchant_id,

      )async{
    try {
      var update1=await ShadulofchargesRepository().AdddCharges(name, rangeamount, percentage, fixedamount, status, merchant_id);
      print('profile update ${update1.merchantId}');
      if(update1.name!=null){
        _addcharges.add(_addcharges as addShadulofCharges);

      }


    } catch (e) {
      print("error $e");

    }
  }

  //..................................... update Schedule of charges.........................................................
  Future updateSchedulOfCharges(
      String name,
      String rangeamount,
      String percentage,
      String fixedamount,
      String status,
      String merchant_id,
      String charges_id

      )async{
    try {
      var update1=await ShadulofchargesRepository().updatecharges(name, rangeamount, percentage, fixedamount, status, merchant_id,charges_id);
      print('profile update ${update1.merchantId}');
      if(update1.name!=null){
        _addcharges.add(_addcharges as addShadulofCharges);

      }


    } catch (e) {
      print("error $e");

    }
  }

  //..............................delete the charges.........................................................

  Future<void> deletecharges(String id) async {
    var result = await ShadulofchargesRepository().Deletecharges(id);
    // print('get Brand details: $result');
    //
    // getmerchant=merchants_list.fromJson(result);
    // getmerchant!.data!.forEach((element) {
    //   print(element.name);
    // });
    notifyListeners();
  }


  // void addCharge(ScheduleChargesModel charges) {
  //   scheduleCharges.add(charges);
  //   notifyListeners();
  // }
  //
  // void updateCharge(int index, ScheduleChargesModel charges) {
  //   scheduleCharges[index] = charges;
  //   notifyListeners();
  // }
  //
  // void deleteCharge(int index) {
  //   scheduleCharges.removeAt(index);
  //   notifyListeners();
  // }
}

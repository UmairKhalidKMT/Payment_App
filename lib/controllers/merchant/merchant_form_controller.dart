import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:payment_app/Repository/merchant_repository.dart';
import 'package:payment_app/models/merchant/addmerchant_model.dart';


import '../../models/merchant/merchant_details.dart';

class MerchantController extends ChangeNotifier {
  merchants_list? getmerchant;
  List<addmerchants> _addmerchant=[];

  //..............................get the merchant.........................................................

  Future<void> fetchingmerchant() async {
    var result = await MerchantRepository().fetchingmerchant();
    print('get Brand details: $result');

    getmerchant=merchants_list.fromJson(result);
    getmerchant!.data!.forEach((element) {
      print(element.name);
    });
    notifyListeners();
  }

  //..................................... create merchant.........................................................
  Future createmerchat(
      String name,
      String phone,
      String email,
      String bussiness_name,
      String status,
      String adress,
      String subgroup_id
      )async{
    try {
      var update1=await MerchantRepository().Addmerchant(name, phone, email, bussiness_name, status, adress, subgroup_id);
      print('profile update ${update1.name}');
      if(update1.name!=null){
        _addmerchant.add(_addmerchant as addmerchants);

      }


    } catch (e) {
      print("error $e");

    }
    }

  //..............................delete the merchant.........................................................

  Future<void> deletemerhant(String id) async {
    var result = await MerchantRepository().Deletemerchant(id);
    // print('get Brand details: $result');
    //
    // getmerchant=merchants_list.fromJson(result);
    // getmerchant!.data!.forEach((element) {
    //   print(element.name);
    // });
    notifyListeners();
  }


  //..................................... update merchant.........................................................
  Future updatemerchant(
      String name,
      String phone,
      String email,
      String bussiness_name,
      String status,
      String adress,
      String subgroup_id,
      String merchantid
      )async{
    try {
      var update1=await MerchantRepository().updatemerchant(name, phone, email, bussiness_name, status, adress, subgroup_id,merchantid);
      print('profile update ${update1.name}');
      if(update1.name!=null){
        _addmerchant.add(_addmerchant as addmerchants);

      }


    } catch (e) {
      print("error $e");

    }
  }




}

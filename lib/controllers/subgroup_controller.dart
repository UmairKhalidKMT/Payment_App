

import 'package:flutter/material.dart';
import 'package:payment_app/Repository/merchant_repository.dart';
import 'package:payment_app/Repository/subgroup_repository.dart';


import '../../models/merchant/merchant_details.dart';
import '../models/subgroup_list.dart';

class SubgroupController extends ChangeNotifier {

  subgroup_list? getsubgroup_list;

  Future<void> fetchingsubgroup() async {
    var result = await SubgroupRepository().fetchingsubgroup();
    print('get Brand details: $result');
    getsubgroup_list=subgroup_list.fromJson(result);
    getsubgroup_list!.data!.forEach((element) {
      print(element.subgroupName);
    });
    notifyListeners();
  }




// void addMerchant(Merchant merchant) {
//   merchants.add(merchant);
//   notifyListeners();
// }
//
// void updateMerchant(int index, Merchant merchant) {
//   merchants[index] = merchant;
//   notifyListeners();
// }
//
// void deleteMerchant(int index) {
//   merchants.removeAt(index);
//   notifyListeners();
// }
}

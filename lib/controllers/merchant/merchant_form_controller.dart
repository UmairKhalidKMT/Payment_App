import 'package:flutter/material.dart';
import 'package:payment_app/models/merchant/merchant_form_model.dart';

class MerchantController extends ChangeNotifier {
  List<Merchant> merchants = [];

  void addMerchant(Merchant merchant) {
    merchants.add(merchant);
    notifyListeners();
  }

  void updateMerchant(int index, Merchant merchant) {
    merchants[index] = merchant;
    notifyListeners();
  }

  void deleteMerchant(int index) {
    merchants.removeAt(index);
    notifyListeners();
  }
}

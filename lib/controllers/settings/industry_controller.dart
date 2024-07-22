import 'package:flutter/material.dart';
import 'package:payment_app/models/settings/industry_model.dart';

class IndustryController extends ChangeNotifier {
  List<IndustryModel> indutries = [];

  void addIndustry(IndustryModel industry) {
    indutries.add(industry);
    notifyListeners();
  }

  void updateIndustry(index, IndustryModel industry) {
    indutries[index] = industry;
    notifyListeners();
  }

  void removeIndustry(index) {
    indutries.removeAt(index);
    notifyListeners();
  }
}

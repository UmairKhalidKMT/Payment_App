import 'package:flutter/material.dart';
import 'package:payment_app/models/settings/region_model.dart';

class RegionController extends ChangeNotifier {
  List<RegionModel> regions = [];

  void addRegion(RegionModel regionModel) {
    regions.add(regionModel);
    notifyListeners();
  }

  void updateRegion(index, RegionModel regionModel) {
    regions[index] = regionModel;
    notifyListeners();
  }

  void removeRegion(index) {
    regions.removeAt(index);
  }
}

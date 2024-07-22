import 'package:flutter/material.dart';
import 'package:payment_app/models/settings/country_model.dart';

class CountryController extends ChangeNotifier {
  List<Country> countries = [];

  void addCity(Country country) {
    countries.add(country);
    notifyListeners();
  }

  void updateCity(int index, Country country) {
    countries[index] = country;
    notifyListeners();
  }

  void deleteCity(int index) {
    countries.removeAt(index);
    notifyListeners();
  }
}

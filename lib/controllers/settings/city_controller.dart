import 'package:flutter/material.dart';
import 'package:payment_app/models/settings/city_model.dart';

class CityController extends ChangeNotifier {
  List<City> cities = [];

  void addCity(City city) {
    cities.add(city);
    notifyListeners();
  }

  void updateCity(int index, City city) {
    cities[index] = city;
    notifyListeners();
  }

  void deleteCity(int index) {
    cities.removeAt(index);
    notifyListeners();
  }
}

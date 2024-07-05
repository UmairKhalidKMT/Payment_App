import 'package:flutter/material.dart';
import 'package:payment_app/models/user/user_model.dart';

class UserController extends ChangeNotifier {
  List<UserModel> users = [];

  void addUser(UserModel user) {
    users.add(user);
    notifyListeners();
  }

  void updateUser(int index, UserModel user) {
    users[index] = user;
    notifyListeners();
  }

  void deleteUser(int index) {
    users.removeAt(index);
    notifyListeners();
  }
}

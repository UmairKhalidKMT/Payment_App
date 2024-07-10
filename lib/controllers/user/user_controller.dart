import 'package:flutter/material.dart';
import 'package:payment_app/Repository/users_repository.dart';
import 'package:payment_app/models/user/user_model.dart';

class UserController extends ChangeNotifier {
  List<Rigister_user> _users = [];
  List<UserModel> users = [];

  //..................................... Rigister User.........................................................
  Future RegisterUser(
      String firstName,
      String lastName,
      String username,
      String password ,
      String phone ,
      String email ,
      String address,
      String status,
      String subgroup_id,
      String role_id

      )async{
    try {
      var update1=await UsersRepository().Rigisterusers(firstName, lastName, username, password, phone, email, address, status, subgroup_id, role_id);

      print('profile update ${update1.username}');
      if(update1.username!=null){
        _users.add(_users as Rigister_user);

      }


    } catch (e) {
      print("error $e");

    }
  }









  // void addUser(UserModel user) {
  //   users.add(user);
  //   notifyListeners();
  // }
  //
  // void updateUser(int index, UserModel user) {
  //   users[index] = user;
  //   notifyListeners();
  // }
  //
  // void deleteUser(int index) {
  //   users.removeAt(index);
  //   notifyListeners();
  // }
}

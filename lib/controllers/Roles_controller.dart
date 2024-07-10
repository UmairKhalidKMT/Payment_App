


import 'package:flutter/cupertino.dart';
import 'package:payment_app/Repository/Roles_repository.dart';
import 'package:payment_app/models/Roles_model.dart';

class RolesController extends ChangeNotifier{
  Roles? getRoles;


  //..............................get the Roles.........................................................

  Future<void> fetchingRoles() async {
    var result = await RolesRepository().fetchingRoles();
    print('get Brand details: $result');

    getRoles=Roles.fromJson(result);
    getRoles!.data!.forEach((element) {
      print(element.roleName);
    });
    notifyListeners();
  }




}
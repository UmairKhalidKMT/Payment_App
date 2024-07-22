import 'package:flutter/material.dart';
import 'package:payment_app/models/settings/group_model.dart';

class GroupController extends ChangeNotifier {
  List<GroupModel> groups = [];

  void addGroup(GroupModel groupModel) {
    groups.add(groupModel);
    notifyListeners();
  }

  void updateGroup(index, GroupModel groupModel) {
    groups[index] = groupModel;
    notifyListeners();
  }

  void removeGroup(index) {
    groups.removeAt(index);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:piriing/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserData? _user;

  UserData? get user => _user;

  void updateUser(UserData newUser) {
    _user = newUser;
    notifyListeners();
  }
}

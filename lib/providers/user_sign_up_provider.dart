import 'package:flutter/material.dart';
import 'package:project_v/models/user_model.dart';

class UserSignUpProvider extends ChangeNotifier {
  late User _user;

  User get user => _user;

  void updateUser({String? email, String? password}) {
    _user = User(
    
      email: email ?? _user.email,
      password: password ?? _user.password,
    );
    notifyListeners();
  }

  void resetUser() {
    _user = User(email: '', password: '');
    notifyListeners();
  }
}
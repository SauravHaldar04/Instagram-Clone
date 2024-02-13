import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart' as model;
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  model.User? _user;
  final AuthMethods _authMethods = AuthMethods();

  model.User getUser() {
    return _user!;
  }

  Future<void> refreshUser() async {
    model.User user = await _authMethods.getUserDetails();
    _user = user;
    print(_user!.username);
    notifyListeners();
  }
}

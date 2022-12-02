import 'dart:convert';

import 'package:alma_web/src/controllers/user/user_state.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:alma_web/src/data/repository/user/user_repository.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class UserController extends ChangeNotifier {
  List<User> users = [];
  
  var state = UserState.idle;

  UserRepository repository;
  UserController(this.repository) {
    _getAllStudents();
  }

  Future<void> _getAllStudents() async {
    setState(UserState.loading);

    try {
      String token = await SharedPref().read("token");
      User user = User.fromJson(json.decode(await SharedPref().read("user")));

      if (user.role == "Student") return;

      users = await repository.getAllUsers(token);
      users = users.where((element) => element.role == 'Student').toList();

      setState(UserState.success);
    } catch (e) {
      setState(UserState.error);
      Exception(e.toString());
    }
  }

  void setState(UserState state) {
    this.state = state;
    notifyListeners();
  }
}

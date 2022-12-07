import 'dart:convert';

import 'package:alma_web/src/controllers/user/user_state.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:alma_web/src/data/repository/user/user_repository.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class UserController extends ChangeNotifier {
  List<User> users = [];
  List<User> usersAux = [];

  var state = UserState.idle;

  int page = 1;
  bool isLastPage = false;

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

      usersAux = await repository.getAllUsers(token, page);
      usersAux = usersAux.where((element) => element.role == 'Student').toList();
      users.addAll(usersAux);

      setState(UserState.success);
    } catch (e) {
      setState(UserState.error);
      Exception(e.toString());
    }
  }

  void filterSearchResults(String query) {
    setState(UserState.idle);

    List<User> dummySearchList = [];
    dummySearchList.addAll(usersAux);

    if (query.isNotEmpty) {
      List<User> dummyListData = [];
      for (User item in dummySearchList) {
        if (item.name!.contains(query)) {
          dummyListData.add(item);
          notifyListeners();
        }
      }
      users.clear();
      users.addAll(dummyListData);
      notifyListeners();
      return;
    } else {
      users.clear();
      users.addAll(usersAux);
      notifyListeners();
    }
  }

  void setState(UserState state) {
    this.state = state;
    notifyListeners();
  }

  void nextPage() {
    isLastPage = usersAux.length < 10;

    if (isLastPage) {
      return;
    }
    page++;
    _getAllStudents();
  }

  void backPage() {
    if (page == 1) {
      return;
    }
    page--;
    _getAllStudents();
  }

}

import 'dart:convert';

import 'package:alma_web/src/controllers/profile/profile_state.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class ProfileController extends ChangeNotifier {
  User user;
  var state = ProfileState.idle;

  ProfileController(this.user) {
    _getUser();
  }

  Future<void> _getUser() async {
    state = ProfileState.loading;
    notifyListeners();

    try {
      user = User.fromJson(json.decode(await SharedPref().read("user")));
      state = ProfileState.success;
      notifyListeners();
    } catch (e) {
      state = ProfileState.error;
      notifyListeners();

      throw Exception(e.toString());
    }
  }
}

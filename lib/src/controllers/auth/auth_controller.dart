import 'dart:convert';

import 'package:alma_web/src/controllers/auth/auth_sate.dart';
import 'package:alma_web/src/data/models/auth/auth_model.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:alma_web/src/data/repository/auth/auth_repository.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class AuthController extends ChangeNotifier {
  String email = '';
  String password = '';
  String? message;
  bool checked = false;
  bool obscurePassword = true;
  var state = AuthState.idle;

  AuthRepository authRepository;
  AuthController(this.authRepository);

  Future<void> authAction() async {
    setState(AuthState.authenticanting);
    try {
      Auth auth = await authRepository.authRequest(email, password);
      
      if (auth.token == null) {
        setMessage(auth.message ?? 'Usuário não encontrado ao tentar autenticar!');
        throw Exception('Usuário não encontrado ao tentar autenticar!');
      }

      if (!await saveTokenSharedPref(auth.token!)) {
        setMessage('Token não foi salvo nas preferencias!');
        throw Exception('Token não foi salvo nas preferencias!');
      }

      if (!await saveUserSharedPref(auth.user!)) {
        setMessage('Usuário não foi salvo nas preferências!');
        throw Exception('Usuário não foi salvo nas preferências!');
      }

      setMessage('Autenticado com sucesso!');
      setState(AuthState.successAuth);
    } catch (e) {
      setState(AuthState.errorAuth);
      Exception(e);
    }
  }

  Future<bool> saveTokenSharedPref(String token) async {
    return SharedPref().save("token", token);
  }

  Future<bool> saveUserSharedPref(User user) async {
    return SharedPref().save("user", json.encode(user.toJson()));
  }

  void seePasswordAction() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleCheckRemember(bool value) {
    checked = value;
    notifyListeners();
  }

  void setMessage(String value) {
    message = value;
    notifyListeners();
  }

  void setState(AuthState state) {
    this.state = state;
    notifyListeners();
  }
}

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
  AuthController(this.authRepository) {
    init();
  }

  Future<void> init() async {
    bool? rememberUser = await SharedPref().read('rememberUser');

    if (rememberUser != null) {
      if (rememberUser) {
        setState(AuthState.isRememberUser);
        return;
      }
      setState(AuthState.idle);
      return;
    }

    setState(AuthState.idle);
  }

  Future<void> authAction() async {
    setState(AuthState.authenticanting);
    try {
      String? token = await SharedPref().read('token');
      Auth auth = await authRepository.authRequest(email, password, token ?? '');

      if (auth.token == null) {
        setMessage(
            auth.message ?? 'Usuário não encontrado ao tentar autenticar!');
        throw Exception('Usuário não encontrado ao tentar autenticar!');
      }

      if (!await _saveTokenSharedPref(auth.token!)) {
        setMessage('Token não foi salvo nas preferencias!');
        throw Exception('Token não foi salvo nas preferencias!');
      }

      if (!await _saveUserSharedPref(auth.user!)) {
        setMessage('Usuário não foi salvo nas preferências!');
        throw Exception('Usuário não foi salvo nas preferências!');
      }

      if (!await _rememberUser()) {
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

  Future<bool> _saveTokenSharedPref(String token) {
    return SharedPref().save("token", token);
  }

  Future<bool> _saveUserSharedPref(User user) {
    return SharedPref().save("user", json.encode(user.toJson()));
  }

  Future<bool> _rememberUser() {
    return SharedPref().saveBool("rememberUser", checked);
  }

  void seePasswordAction() {
    setState(AuthState.idle);

    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleCheckRemember(bool value) {
    setState(AuthState.idle);

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

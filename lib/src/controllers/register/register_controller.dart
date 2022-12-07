import 'package:alma_web/src/controllers/register/register_state.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:alma_web/src/data/repository/register/register_repository.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/widgets.dart';

class RegisterController extends ChangeNotifier {
  String name = '';
  String email = '';
  String phone = '';
  String cpf = '';
  String password = '';
  String? message;
  bool checked = false;
  bool obscurePassword = true;
  var state = RegisterState.idle;

  RegisterRepository repository;
  RegisterController(this.repository);

  Future<void> createUser() async {
    setState(RegisterState.loading);

    try {
      if (!_validForm()) return;

      User user = await repository.createUser(User(
          name: name,
          email: email,
          phone: phone,
          cpf: cpf,
          password: password));

      user = User.fromJson(user.toJson());

      if (user.toJson().isEmpty) {
        throw Exception('Usuário não foi cadastrado!');
      }

      setState(RegisterState.success);
    } catch (e) {
      setState(RegisterState.error);
      Exception(e.toString());
    }
  }

  void seePasswordAction() {
    setState(RegisterState.idle);
    
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleCheckTerms(bool value) {
    setState(RegisterState.idle);

    checked = value;
    notifyListeners();
  }

  void setState(RegisterState state) {
    this.state = state;
    notifyListeners();
  }

  bool _validForm() {
    if (name.isEmpty || cpf.isEmpty || phone.isEmpty || password.isEmpty) {
      message = 'Preencha os campos vazios!';
      setState(RegisterState.formWarnings);
      return false;
    }
    if (!_validCPF(cpf)) {
      message = 'Digite um CPF válido!';
      setState(RegisterState.formWarnings);
      return false;
    }
    if (!checked) {
      message = 'É necessário aceitar os termos e condições do sistema!';
      setState(RegisterState.formWarnings);
      return false;
    }

    return true;
  }

  bool _validCPF(String cpf) {
    if (!CPFValidator.isValid(cpf)) {
      return false;
    }
    return true;
  }
}

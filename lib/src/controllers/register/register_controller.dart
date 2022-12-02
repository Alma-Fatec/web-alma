import 'package:alma_web/src/controllers/register/register_state.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:alma_web/src/data/repository/register/register_repository.dart';
import 'package:flutter/widgets.dart';

class RegisterController extends ChangeNotifier {
  String name = '';
  String email = '';
  String phone = '';
  String cpf = '';
  String password = '';
  bool checked = false;
  var state = RegisterState.idle;

  RegisterRepository repository;
  RegisterController(this.repository);

  Future<void> createUser() async {
    state = RegisterState.loading;
    notifyListeners();

    try {
      User user = await repository.createUser(User(
          name: name,
          email: email,
          phone: phone,
          cpf: formatCpf(cpf),
          password: password));

      user = User.fromJson(user.toJson());

      if (user.toJson().isEmpty) {
        throw Exception('Usuário não foi cadastrado!');
      }

      state = RegisterState.success;
      notifyListeners();
    } catch (e) {
      state = RegisterState.error;
      notifyListeners();

      throw Exception(e.toString());
    }
  }

  void toggleCheckTerms(bool value) {
    checked = value;
    notifyListeners();
  }

  String formatCpf(String cpf) {
    String cpfFormatted = "";

    List<String> cpfToList = cpf.split("");
    cpfToList.insert(3, ".");
    cpfToList.insert(7, ".");
    cpfToList.insert(11, "-");

    cpfToList.map((e) => cpfFormatted += e).toString();

    return cpfFormatted;
  }
}

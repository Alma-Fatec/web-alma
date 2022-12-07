import 'package:alma_web/src/data/api/client_http.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterRepository {
  User user;
  HttpClient client;
  RegisterRepository(this.user, this.client);

  Future<User> createUser(User user) async {
    try {
      final response = await Dio().post(
        "${dotenv.env['BASE_URL']}/users",
        data: {
          "name": user.name,
          "cpf": user.cpf,
          "phone": user.phone,
          "email": user.email,
          "password": user.password,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Não foi possível realizar a requisição');
      }

      user = User.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }

    return user;
  }
}

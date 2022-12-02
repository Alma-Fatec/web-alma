import 'package:alma_web/src/data/models/auth/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRepository {
  Auth auth;
  AuthRepository(this.auth);

  Future<Auth> authRequest(String email, String password) async {
    try {
      final response = await Dio().post(
        "${dotenv.env['BASE_URL']}/session/login/",
        data: {"email": email, "password": password},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Não foi possível realizar a requisição');
      }

      auth = Auth.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }

    return auth;
  }
}

import 'package:alma_web/src/data/api/client_http.dart';
import 'package:alma_web/src/data/models/auth/auth_model.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  Auth auth;
  HttpClient client;
  AuthRepository(this.auth, this.client);

  Future<Auth> authRequest(String email, String password, String token) async {
    try {
      final response = await client.post(
        "/session/login/",
        data: {"email": email, "password": password},
        options: Options(
          headers: { "Authorization": "Bearer $token" }
        ),
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

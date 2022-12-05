import 'package:alma_web/src/data/api/client_http.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  HttpClient client;

  UserRepository(this.client);

  Future<List<User>> getAllUsers(String token) async {
    List<User> users = [];

    try {
      final response = await client.get(
        "/users",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Não foi possível realizar a requisição');
      }

      response.data['users'].forEach((user) => users.add(User.fromJson(user)));
    } catch (e) {
      throw Exception(e.toString());
    }

    return users;
  }
}

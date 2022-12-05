import 'package:alma_web/src/data/api/client_http.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:dio/dio.dart';

class ListClassBlockRepository {
  HttpClient client;
  ListResponse listResponses;

  ListClassBlockRepository(this.listResponses, this.client);

  Future<ListResponse> getListClassBlock(String token) async {
    try {
      final response = await client.get(
        "/classesBlock",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      listResponses = ListResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }

    return listResponses;
  }

  Future<void> deleteClassBlock(String token, String id) async {
    try {
      await client.delete(
        "/classesBlock/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}

import 'package:alma_web/src/data/api/client_http.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:dio/dio.dart';

class ListClassRepository {
  HttpClient client;
  ListResponse listResponses;
  
  ListClassRepository(this.listResponses, this.client);

  Future<ListResponse> getListClasses(String token) async {
    try {
      final response = await client.get(
        "/classes",
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

  Future<void> deleteClass(String token, String id) async {
    try {
      await client.delete(
        "/classes/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

import 'package:alma_web/src/data/api/client_http.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:dio/dio.dart';

class ListAssignmentRepository {
  HttpClient client;
  ListResponse listResponses;

  ListAssignmentRepository(this.listResponses, this.client);

  Future<ListResponse> getListAssignments(String token) async {
    try {
      final response = await client.get(
        "/assignments",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      listResponses = ListResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }

    return listResponses;
  }

  Future<void> deleteAssignment(String token, String id) async {
    try {
      await client.delete(
        "/assignments/$id",
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

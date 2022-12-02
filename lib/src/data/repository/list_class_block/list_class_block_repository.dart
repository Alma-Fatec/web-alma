import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListClassBlockRepository {
  ListResponse listResponses;

    ListClassBlockRepository(this.listResponses);

  Future<ListResponse> getListClassBlock(String token) async {
    try {
      final response = await Dio().get(
        "${dotenv.env['BASE_URL']}/classesBlock",
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
      await Dio().delete(
        "${dotenv.env['BASE_URL']}/classesBlock/$id",
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

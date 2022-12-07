import 'package:alma_web/src/data/api/client_http.dart';
import 'package:alma_web/src/data/models/assignment/assignment_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:file_picker/file_picker.dart';

class AssignmentRepository {
  HttpClient client;
  ListResponse listResponses;

  AssignmentRepository(this.client, this.listResponses);

  Future<void> createAssignment(
      String token, Assignment assignment, {PlatformFile? file}) async {
    try {
      final response = await client.post(
        "/assignments",
        data: FormData.fromMap({
          "title": assignment.title,
          "description": assignment.description,
          "kind": assignment.kind,
          "cover": file == null ? "" : MultipartFile.fromBytes(
                  file.bytes!,
                  filename: file.name,
                  contentType: MediaType("image", "png"),
                ),
          "class": assignment.classe,
          "answer": assignment.answer,
          "options": assignment.options,
        }),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Não foi possível realizar a requisição');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

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
      throw Exception(e.toString());
    }
    return listResponses;
  }
}

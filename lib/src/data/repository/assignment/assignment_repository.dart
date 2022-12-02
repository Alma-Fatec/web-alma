import 'package:alma_web/src/data/models/assignment/assignment_model.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AssignmentRepository {

  Future<void> createAssignment(String token, PlatformFile file, Assignment assignment) async {
    try {
      final response = await Dio().post(
        "${dotenv.env['BASE_URL']}/assignments",
        data: FormData.fromMap({
          "description": assignment.description,
          "cover": MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
            contentType: MediaType("image", "png"),
          ),
          "name": assignment.name,
          "title": assignment.title
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
      throw Exception(e);
    }
  }
}

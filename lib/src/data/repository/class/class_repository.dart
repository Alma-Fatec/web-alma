import 'package:alma_web/src/data/models/class/class_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClassRepository {
  Future<void> createClass(String token, PlatformFile file, Class classe,
      List<Map<String, dynamic>> blocks) async {
    try {
      final response = await Dio().post(
        "${dotenv.env['BASE_URL']}/classes",
        data: FormData.fromMap({
          "description": classe.description,
          "cover": MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
            contentType: MediaType("image", "png"),
          ),
          "order": classe.order,
          "name": classe.name,
          blocks.map((e) => e.keys)
                  .toString()
                  .replaceAll('(', '')
                  .replaceAll(')', ''):
          blocks.map((e) => e.values)
                  .toString()
                  .replaceAll('(', '')
                  .replaceAll(')', ''),
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

  Future<ListResponse> getListClassBlock(String token) async {
    ListResponse listResponses;
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
}

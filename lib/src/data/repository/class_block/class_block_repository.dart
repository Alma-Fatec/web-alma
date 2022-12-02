import 'package:alma_web/src/data/models/block/block_model.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClassBlockRepository {
  Future<void> createBlock(
      String token, PlatformFile file, Block block, List<Map<String, dynamic>> users) async {
    
    try {
      final response = await Dio().post(
        '${dotenv.env['BASE_URL']}/classesBlock',
        data: FormData.fromMap({
          "title": block.title,
          "description": block.description,
          users.map((e) => e.keys)
                  .toString()
                  .replaceAll('(', '')
                  .replaceAll(')', ''):
          users.map((e) => e.values)
                  .toString()
                  .replaceAll('(', '')
                  .replaceAll(')', ''),
          "cover": MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
            contentType: MediaType("image", "png"),
          ),
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

  Future<List<User>> getUsers(String token) async {
    List<User> users = [];

    try {
      final response = await Dio().get(
        "${dotenv.env['BASE_URL']}/users",
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

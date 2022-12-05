import 'dart:convert';

import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomInterceptors extends InterceptorsWrapper {
  final dio = Dio(BaseOptions(baseUrl: '${dotenv.env['BASE_URL']}'));
  String? token;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    await _getToken();

    if (token != null && token != '') {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (await _refresh()) {
        //set bearer
        err.requestOptions.headers["Authorization"] = "Bearer $token";

        //create request with new access token
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );

        final cloneReq = await Dio().request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(cloneReq);
      }
    }

    super.onError(err, handler);
  }

  Future<bool> _refresh() async {
    try {
      User user = User.fromJson(json.decode(await SharedPref().read('user_id')));
      final response = await dio.post(
        '/session/refresh',
        data: { "user_id": user.id }
      );

      if (response.statusCode == 201) {
        _defineNewToken(response.data['token']);
        return true;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _getToken() async {
    token = await SharedPref().read('token');
  }

  Future<void> _defineNewToken(String newToken) async {
    token = newToken;
    await SharedPref().save('token', newToken);
  }
}

import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auth_model.g.dart';

@JsonSerializable()
class Auth {
  String? token;
  User? user;
  String? message;

  Auth({this.token, this.user, this.message});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

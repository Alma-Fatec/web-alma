import 'package:alma_web/src/data/models/block/block_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? name;
  String? cpf;
  String? email;
  String? phone;
  String? password;
  bool? isActive;
  String? role;
  List<Block>? blocks;

  User(
      {this.id,
      this.name,
      this.cpf,
      this.email,
      this.phone,
      this.password,
      this.isActive,
      this.role,
      this.blocks});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

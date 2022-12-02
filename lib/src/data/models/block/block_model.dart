import 'package:json_annotation/json_annotation.dart';
part 'block_model.g.dart';

@JsonSerializable()
class Block {
  String? id;
  String? title;
  String? description;
  String? cover;
  String? createdAt;
  String? createdBy;
  List<dynamic>? users;

  Block(
      {this.id,
      this.title,
      this.description,
      this.cover,
      this.createdAt,
      this.createdBy,
      this.users});

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
  Map<String, dynamic> toJson() => _$BlockToJson(this);
}

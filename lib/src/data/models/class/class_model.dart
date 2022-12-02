import 'package:json_annotation/json_annotation.dart';
part 'class_model.g.dart';

@JsonSerializable()
class Class {
  int? id;
  String? name;
  String? description;
  String? cover;
  int? order;
  List<dynamic>? blocks;
  String? createdAt;
  String? createdBy;

  Class({
    this.id,
    this.name,
    this.description,
    this.cover,
    this.order,
    this.blocks,
    this.createdAt,
    this.createdBy,
  });

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
  Map<String, dynamic> toJson() => _$ClassToJson(this);
}

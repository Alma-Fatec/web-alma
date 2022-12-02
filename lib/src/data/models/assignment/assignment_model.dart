import 'package:json_annotation/json_annotation.dart';
part 'assignment_model.g.dart';

@JsonSerializable()
class Assignment {
  int? id;
  String? title;
  String? description;
  String? cover;
  String? name;
  String? createdAt;
  String? createdBy;

  Assignment({this.id,
      this.title,
      this.description,
      this.cover,
      this.name,
      this.createdAt,
      this.createdBy});

  factory Assignment.fromJson(Map<String, dynamic> json) => _$AssignmentFromJson(json);
  Map<String, dynamic> toJson() => _$AssignmentToJson(this);
}

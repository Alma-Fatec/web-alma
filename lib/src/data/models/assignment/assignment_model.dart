import 'package:json_annotation/json_annotation.dart';
part 'assignment_model.g.dart';

@JsonSerializable()
class Assignment {
  int? id;
  String? title;
  String? description;
  String? kind;
  String? cover;

  @JsonKey(name: "class")
  List<int>? classe;

  String? answer;
  String? createdAt;
  String? createdBy;
  List<Map<String, dynamic>>? options;

  Assignment(
      {this.id,
      this.title,
      this.description,
      this.kind,
      this.cover,
      this.classe,
      this.answer,
      this.createdAt,
      this.createdBy,
      this.options});

  factory Assignment.fromJson(Map<String, dynamic> json) => _$AssignmentFromJson(json);
  Map<String, dynamic> toJson() => _$AssignmentToJson(this);
}

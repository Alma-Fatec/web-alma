import 'package:json_annotation/json_annotation.dart';
part 'list_response_model.g.dart';

@JsonSerializable()
class ListResponse {
  int? page;
  int? limit;
  String? message;
  List<Map<String, dynamic>>? data;

  ListResponse({this.page, this.limit, this.message, this.data});

  factory ListResponse.fromJson(Map<String, dynamic> json) => _$ListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListResponseToJson(this);
}

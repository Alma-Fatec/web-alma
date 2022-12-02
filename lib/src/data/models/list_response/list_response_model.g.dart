// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse _$ListResponseFromJson(Map<String, dynamic> json) => ListResponse(
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ListResponseToJson(ListResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'message': instance.message,
      'data': instance.data,
    };

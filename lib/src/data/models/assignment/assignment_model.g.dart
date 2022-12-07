// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assignment _$AssignmentFromJson(Map<String, dynamic> json) => Assignment(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      kind: json['kind'] as String?,
      cover: json['cover'] as String?,
      classe: (json['class'] as List<dynamic>?)?.map((e) => e as int).toList(),
      answer: json['answer'] as String?,
      createdAt: json['createdAt'] as String?,
      createdBy: json['createdBy'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$AssignmentToJson(Assignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'kind': instance.kind,
      'cover': instance.cover,
      'class': instance.classe,
      'answer': instance.answer,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'options': instance.options,
    };

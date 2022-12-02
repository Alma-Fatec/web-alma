// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) => Class(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      cover: json['cover'] as String?,
      order: json['order'] as int?,
      blocks: json['blocks'] as List<dynamic>?,
      createdAt: json['createdAt'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'cover': instance.cover,
      'order': instance.order,
      'blocks': instance.blocks,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
    };

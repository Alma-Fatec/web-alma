// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      cover: json['cover'] as String?,
      createdAt: json['createdAt'] as String?,
      createdBy: json['createdBy'] as String?,
      users: json['users'] as List<dynamic>?,
    );

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'cover': instance.cover,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'users': instance.users,
    };

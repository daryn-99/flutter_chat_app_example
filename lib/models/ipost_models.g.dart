// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipost_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    count: json['count'] as int,
    comment: json['comment'] as int,
    id: json['_id'] as String,
    title: json['title'] as String,
    coverImage: json['coverImage'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'count': instance.count,
      'comment': instance.comment,
      '_id': instance.id,
      'title': instance.title,
      'coverImage': instance.coverImage,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipost_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    title: json['title'] as String,
    caption: json['caption'] as String,
    coverImage: json['coverImage'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'title': instance.title,
      'caption': instance.caption,
      'coverImage': instance.coverImage,
    };

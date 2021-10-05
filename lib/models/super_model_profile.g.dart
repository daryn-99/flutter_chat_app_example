// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_model_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModelProfile _$SuperModelProfileFromJson(Map<String, dynamic> json) {
  return SuperModelProfile(
    dato: (json['dato'] as List<dynamic>)
        .map((e) => Profile.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SuperModelProfileToJson(SuperModelProfile instance) =>
    <String, dynamic>{
      'dato': instance.dato,
    };

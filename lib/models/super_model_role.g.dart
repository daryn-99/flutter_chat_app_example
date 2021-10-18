// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_model_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModelRole _$SuperModelRoleFromJson(Map<String, dynamic> json) {
  return SuperModelRole(
    info: (json['info'] as List<dynamic>)
        .map((e) => Role.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SuperModelRoleToJson(SuperModelRole instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

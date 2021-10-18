import 'package:chat/models/role_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'super_model_role.g.dart';

@JsonSerializable()
class SuperModelRole {
  List<Role> info;
  SuperModelRole({this.info});
  factory SuperModelRole.fromJson(Map<String, dynamic> json) =>
      _$SuperModelRoleFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelRoleToJson(this);
}

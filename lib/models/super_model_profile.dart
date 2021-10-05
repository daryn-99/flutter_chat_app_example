import 'package:chat/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'super_model_profile.g.dart';

@JsonSerializable()
class SuperModelProfile {
  List<Profile> dato;
  SuperModelProfile({this.dato});
  factory SuperModelProfile.fromJson(Map<String, dynamic> json) =>
      _$SuperModelProfileFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelProfileToJson(this);
}

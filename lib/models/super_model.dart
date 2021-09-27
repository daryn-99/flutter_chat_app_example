import 'package:chat/models/ipost_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'super_model.g.dart';

@JsonSerializable()
class SuperModel {
  List<Post> data;
  SuperModel({this.data});
  factory SuperModel.fromJson(Map<String, dynamic> json) =>
      _$SuperModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelToJson(this);
}

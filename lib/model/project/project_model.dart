import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

@JsonSerializable(checked: true)
class ProjectModel {
  @JsonKey(defaultValue: "")
  final String projPath;

  @JsonKey(defaultValue: "")
  final String projName;

  @JsonKey(defaultValue: [])
  final List<ProjectModel> plugins;

  ProjectModel(this.projPath, this.projName, this.plugins);

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}

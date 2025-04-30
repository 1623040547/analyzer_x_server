import 'package:json_annotation/json_annotation.dart';

import 'project_model.dart';

part 'project_build.g.dart';

@JsonSerializable(checked: true)
class ProjectBuildParam {
  String folderPath;

  ProjectBuildParam(this.folderPath);

  factory ProjectBuildParam.fromJson(Map<String, dynamic> json) =>
      _$ProjectBuildParamFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectBuildParamToJson(this);
}

@JsonSerializable(checked: true)
class ProjectBuildResponse {
  ProjectModel project;

  ProjectBuildResponse(this.project);

  factory ProjectBuildResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectBuildResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectBuildResponseToJson(this);
}

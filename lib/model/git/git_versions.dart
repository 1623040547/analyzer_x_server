import 'package:json_annotation/json_annotation.dart';

part 'git_versions.g.dart';

@JsonSerializable(checked: true)
class GitVersionParam {
  final String projPath;

  GitVersionParam(this.projPath);

  factory GitVersionParam.fromJson(Map<String, dynamic> json) =>
      _$GitVersionParamFromJson(json);

  Map<String, dynamic> toJson() => _$GitVersionParamToJson(this);
}

@JsonSerializable(checked: true)
class GitVersionResponse {
  final List<String> tags;

  GitVersionResponse(this.tags);

  factory GitVersionResponse.fromJson(Map<String, dynamic> json) =>
      _$GitVersionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GitVersionResponseToJson(this);
}

import 'package:analyzer_x_server/base/apix.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_version_analysis.g.dart';

@JsonSerializable(checked: true)
class GitVersionAnalysisParam {
  final String projPath;

  String? version;

  GitVersionAnalysisParam({required this.projPath});

  factory GitVersionAnalysisParam.fromJson(Map<String, dynamic> json) =>
      _$GitVersionAnalysisParamFromJson(json);

  Map<String, dynamic> toJson() => _$GitVersionAnalysisParamToJson(this);
}

@JsonSerializable(checked: true)
class GitVersionAnalysisResponse {
  String content = "";

  GitVersionAnalysisResponse();

  factory GitVersionAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$GitVersionAnalysisResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GitVersionAnalysisResponseToJson(this);
}

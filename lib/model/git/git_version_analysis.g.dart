// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_version_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitVersionAnalysisParam _$GitVersionAnalysisParamFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'GitVersionAnalysisParam',
      json,
      ($checkedConvert) {
        final val = GitVersionAnalysisParam(
          projPath: $checkedConvert('projPath', (v) => v as String),
        );
        $checkedConvert('version', (v) => val.version = v as String?);
        return val;
      },
    );

Map<String, dynamic> _$GitVersionAnalysisParamToJson(
        GitVersionAnalysisParam instance) =>
    <String, dynamic>{
      'projPath': instance.projPath,
      'version': instance.version,
    };

GitVersionAnalysisResponse _$GitVersionAnalysisResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'GitVersionAnalysisResponse',
      json,
      ($checkedConvert) {
        final val = GitVersionAnalysisResponse();
        $checkedConvert('content', (v) => val.content = v as String);
        return val;
      },
    );

Map<String, dynamic> _$GitVersionAnalysisResponseToJson(
        GitVersionAnalysisResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

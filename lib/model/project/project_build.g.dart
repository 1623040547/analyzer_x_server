// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_build.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectBuildParam _$ProjectBuildParamFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ProjectBuildParam',
      json,
      ($checkedConvert) {
        final val = ProjectBuildParam(
          $checkedConvert('folderPath', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProjectBuildParamToJson(ProjectBuildParam instance) =>
    <String, dynamic>{
      'folderPath': instance.folderPath,
    };

ProjectBuildResponse _$ProjectBuildResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ProjectBuildResponse',
      json,
      ($checkedConvert) {
        final val = ProjectBuildResponse(
          $checkedConvert('project',
              (v) => ProjectModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProjectBuildResponseToJson(
        ProjectBuildResponse instance) =>
    <String, dynamic>{
      'project': instance.project,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ProjectModel',
      json,
      ($checkedConvert) {
        final val = ProjectModel(
          $checkedConvert('projPath', (v) => v as String? ?? ''),
          $checkedConvert('projName', (v) => v as String? ?? ''),
          $checkedConvert(
              'plugins',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          ProjectModel.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  []),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'projPath': instance.projPath,
      'projName': instance.projName,
      'plugins': instance.plugins,
    };

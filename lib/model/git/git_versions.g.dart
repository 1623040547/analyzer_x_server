// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_versions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitVersionParam _$GitVersionParamFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GitVersionParam',
      json,
      ($checkedConvert) {
        final val = GitVersionParam(
          $checkedConvert('projPath', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$GitVersionParamToJson(GitVersionParam instance) =>
    <String, dynamic>{
      'projPath': instance.projPath,
    };

GitVersionResponse _$GitVersionResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GitVersionResponse',
      json,
      ($checkedConvert) {
        final val = GitVersionResponse(
          $checkedConvert('tags',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$GitVersionResponseToJson(GitVersionResponse instance) =>
    <String, dynamic>{
      'tags': instance.tags,
    };

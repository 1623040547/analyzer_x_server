// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_commit_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitCommitMsgParam _$GitCommitMsgParamFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GitCommitMsgParam',
      json,
      ($checkedConvert) {
        final val = GitCommitMsgParam(
          projPath: $checkedConvert('projPath', (v) => v as String),
        );
        $checkedConvert('staged', (v) => val.staged = v as bool);
        $checkedConvert('unstaged', (v) => val.unstaged = v as bool);
        $checkedConvert('extraMsg', (v) => val.extraMsg = v as String);
        $checkedConvert('msgCount', (v) => val.msgCount = (v as num).toInt());
        $checkedConvert('maxLines', (v) => val.maxLines = (v as num).toInt());
        return val;
      },
    );

Map<String, dynamic> _$GitCommitMsgParamToJson(GitCommitMsgParam instance) =>
    <String, dynamic>{
      'projPath': instance.projPath,
      'staged': instance.staged,
      'unstaged': instance.unstaged,
      'extraMsg': instance.extraMsg,
      'msgCount': instance.msgCount,
      'maxLines': instance.maxLines,
    };

GitCommitMsgResponse _$GitCommitMsgResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'GitCommitMsgResponse',
      json,
      ($checkedConvert) {
        final val = GitCommitMsgResponse();
        $checkedConvert('content', (v) => val.content = v as String);
        return val;
      },
    );

Map<String, dynamic> _$GitCommitMsgResponseToJson(
        GitCommitMsgResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

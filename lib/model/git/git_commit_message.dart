import 'package:json_annotation/json_annotation.dart';

part 'git_commit_message.g.dart';

@JsonSerializable(checked: true)
class GitCommitMsgParam {
  final String projPath;

  bool staged = false;

  bool unstaged = true;

  String extraMsg = "";

  int msgCount = 1;

  int maxLines = 20;

  GitCommitMsgParam({
    required this.projPath,
  });

  factory GitCommitMsgParam.fromJson(Map<String, dynamic> json) =>
      _$GitCommitMsgParamFromJson(json);

  Map<String, dynamic> toJson() => _$GitCommitMsgParamToJson(this);
}

@JsonSerializable(checked: true)
class GitCommitMsgResponse {
  String content = "";

  GitCommitMsgResponse();

  factory GitCommitMsgResponse.fromJson(Map<String, dynamic> json) =>
      _$GitCommitMsgResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GitCommitMsgResponseToJson(this);
}

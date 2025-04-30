import 'package:analyzer_x/analyzer_x.dart';

import 'package:analyzer_x_server/model/xxmodel.dart';

class GitService {
  Future<String> generateCommitMessage(GitCommitMsgParam param) async {
    final analyzer = AICommitAnalyzer.fromPath(
      param.projPath,
      msgCount: param.msgCount,
      maxLines: param.maxLines,
    );

    return analyzer.generateCommitMessage(
      staged: param.staged,
      unstaged: param.unstaged,
      extraMsg: param.extraMsg,
      justPrint: true,
    );
  }

  Future<List<String>> getVersions(String projPath) async {
    final analyzer = AIVersionAnalyzer.fromPath(projPath);
    return analyzer.tags();
  }

  Future<String> analyzeVersion(String projPath, {String? version}) async {
    final analyzer = AIVersionAnalyzer.fromPath(projPath);
    return version == null
        ? analyzer.analyzeLatestVersion()
        : analyzer.analyzeVersion(version);
  }
}

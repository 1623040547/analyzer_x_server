import 'package:analyzer_x/analyzer_x.dart';

class GitService {
  Future<String> generateCommitMessage({
    required String projPath,
    bool staged = true,
    bool unstaged = false,
    String extraMsg = '',
    int msgCount = 1,
    int maxLines = 20,
  }) async {
    final analyzer = AICommitAnalyzer.fromPath(
      projPath,
      msgCount: msgCount,
      maxLines: maxLines,
    );
    
    return analyzer.generateCommitMessage(
      staged: staged,
      unstaged: unstaged,
      extraMsg: extraMsg,
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
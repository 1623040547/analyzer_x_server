import 'package:analyzer_x_server/base/apix.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'git_service.dart';

import 'package:analyzer_x_server/model/xxmodel.dart';

class GitController {
  final _gitService = GitService();

  Router get router {
    final router = Router();

    // 提交信息分析
    router.post('/commit_message', _handleCommitMessage);

    // 版本列表
    router.get('/versions', _handleVersions);

    // 版本分析
    router.post('/version_analysis', _handleVersionAnalysis);

    return router;
  }

  @ApiMeta(GitCommitMsgParam, GitCommitMsgResponse)
  Future<Response> _handleCommitMessage(Request request) async {
    try {
      final param = await request.postParam(GitCommitMsgParam.fromJson);
      final message = await _gitService.generateCommitMessage(param);
      final response = GitCommitMsgResponse()..content = message;
      return ResponseJson.ok(response.toJson);
    } catch (e) {
      return Response.internalServerError(body: '生成提交信息失败: $e');
    }
  }

  @ApiMeta(GitVersionParam, GitVersionResponse)
  Future<Response> _handleVersions(Request request) async {
    try {
      final param = await request.getParam(GitVersionParam.fromJson);
      final versions = await _gitService.getVersions(param.projPath);
      final response = GitVersionResponse(versions);
      return ResponseJson.ok(response.toJson);
    } catch (e) {
      return Response.internalServerError(body: '获取版本列表失败: $e');
    }
  }

  @ApiMeta(GitVersionAnalysisParam, GitVersionAnalysisResponse)
  Future<Response> _handleVersionAnalysis(Request request) async {
    try {
      final param = await request.postParam(GitVersionAnalysisParam.fromJson);
      final content = await _gitService.analyzeVersion(
        param.projPath,
        version: param.version,
      );
      final response = GitVersionAnalysisResponse()..content = content;
      return ResponseJson.ok(response.toJson);
    } catch (e) {
      return Response.internalServerError(body: '版本分析失败: $e');
    }
  }
}

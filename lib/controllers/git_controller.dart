import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/git_service.dart';
import '../model/git/git_commit_message.dart';

class GitController {
  final _gitService = GitService();

  Router get router {
    final router = Router();

    // 提交信息分析
    router.post('/commit_message', _handleCommitMessage);

    // 版本列表
    router.get('/versions', _handleVersions);

    // 版本分析
    router.get('/version_analysis', _handleVersionAnalysis);

    return router;
  }

  Future<Response> _handleCommitMessage(Request request) async {
    try {
      final jsonStr = await request.readAsString();
      final param = GitCommitMsgParam.fromJson(
        jsonDecode(jsonStr) as Map<String, dynamic>,
      );

      final message = await _gitService.generateCommitMessage(param);

      final response = GitCommitMsgResponse()..content = message;
      return Response.ok(
        jsonEncode(response),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(body: '生成提交信息失败: $e');
    }
  }

  Future<Response> _handleVersions(Request request) async {
    try {
      final projPath = request.url.queryParameters['projPath'];
      if (projPath == null) {
        return Response.badRequest(body: '项目路径不能为空');
      }

      final versions = await _gitService.getVersions(projPath);
      return Response.ok(versions.join(','));
    } catch (e) {
      return Response.internalServerError(body: '获取版本列表失败: $e');
    }
  }

  Future<Response> _handleVersionAnalysis(Request request) async {
    try {
      final params = request.url.queryParameters;
      final projPath = params['projPath'];
      final version = params['version'];

      if (projPath == null) {
        return Response.badRequest(body: '项目路径不能为空');
      }

      final analysis = await _gitService.analyzeVersion(
        projPath,
        version: version,
      );
      return Response.ok(analysis);
    } catch (e) {
      return Response.internalServerError(body: '版本分析失败: $e');
    }
  }
}

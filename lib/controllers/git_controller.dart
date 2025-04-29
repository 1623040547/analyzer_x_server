import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/git_service.dart';

class GitController {
  final _gitService = GitService();

  Router get router {
    final router = Router();
    
    // 提交信息分析
    router.get('/commit-message', _handleCommitMessage);
    
    // 版本列表
    router.get('/versions', _handleVersions);
    
    // 版本分析
    router.get('/version-analysis', _handleVersionAnalysis);
    
    return router;
  }

  Future<Response> _handleCommitMessage(Request request) async {
    try {
      final params = request.url.queryParameters;
      final message = await _gitService.generateCommitMessage(
        projPath: params['projPath'] ?? '',
        staged: params['staged'] == 'true',
        unstaged: params['unstaged'] == 'true',
        extraMsg: params['extraMsg'] ?? '',
        msgCount: int.parse(params['msgCount'] ?? '1'),
        maxLines: int.parse(params['maxLines'] ?? '20'),
      );
      return Response.ok(message);
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
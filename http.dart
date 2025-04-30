import 'dart:io';
import 'package:analyzer_x/analyzer_x.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

Future<void> main() async {
 await GitAnalysisServer._instance.start();
 await Future.delayed(Duration(seconds: 10000));
}


class GitAnalysisServer {
  static final GitAnalysisServer _instance = GitAnalysisServer._internal();
  factory GitAnalysisServer() => _instance;
  GitAnalysisServer._internal();

  HttpServer? _server;
  
  Future<void> start() async {
    if (_server != null) return;
    
    var handler = const shelf.Pipeline()
        .addMiddleware(shelf.logRequests())
        .addHandler(_handleRequest);
        
    _server = await io.serve(handler, 'localhost', 8080);
    print('Git分析服务器启动在: ${_server?.address.host}:${_server?.port}');
  }

  Future<shelf.Response> _handleRequest(shelf.Request request) async {
    try {
      switch(request.url.path) {
        case 'commit-message':
          final params = request.url.queryParameters;
          final projPath = params['projPath'];
          final staged = params['staged'] == 'true';
          final unstaged = params['unstaged'] == 'true';
          final extraMsg = params['extraMsg'] ?? '';
          final msgCount = int.parse(params['msgCount'] ?? '1');
          final maxLines = int.parse(params['maxLines'] ?? '20');
          
          if (projPath == null) {
            return shelf.Response.badRequest(body: '项目路径不能为空');
          }

          final analyzer = CommitPromptAnalyzer.fromPath(
            projPath,
            msgCount: msgCount,
            maxLines: maxLines,
          );
          
          final message = await analyzer.generateCommitMessage(
            staged: staged,
            unstaged: unstaged,
            extraMsg: extraMsg,
            justPrint: true,
          );
          
          return shelf.Response.ok(message);

        case 'project-versions':
          final projPath = request.url.queryParameters['projPath'];
          if (projPath == null) {
            return shelf.Response.badRequest(body: '项目路径不能为空');
          }

          final analyzer = VersionPromptAnalyzer.fromPath(projPath);
          final versions = await analyzer.tags();
          
          return shelf.Response.ok(versions.join(','));

        case 'version-analysis':
          final params = request.url.queryParameters;
          final projPath = params['projPath'];
          final version = params['version'];
          
          if (projPath == null) {
            return shelf.Response.badRequest(body: '项目路径不能为空');
          }

          final analyzer = VersionPromptAnalyzer.fromPath(projPath);
          final analysis = version == null 
              ? await analyzer.analyzeLatestVersion()
              : await analyzer.analyzeVersion(version);
              
          return shelf.Response.ok(analysis);

        default:
          return shelf.Response.notFound('未找到请求的接口');
      }
    } catch (e) {
      return shelf.Response.internalServerError(body: '服务器错误: $e');
    }
  }

  void stop() {
    _server?.close();
    _server = null;
  }
}
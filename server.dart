import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:analyzer_x/analyzer_x.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '8080')
    ..addFlag('help', abbr: 'h', negatable: false)
    ..addFlag('daemon', abbr: 'd', negatable: false, help: '以守护进程模式运行');

  final results = parser.parse(args);

  if (results['help']) {
    print('使用方法: dart server.dart [选项]');
    print(parser.usage);
    return;
  }

  final server = GitAnalysisServer();
  await server.start(
    port: int.parse(results['port']),
    daemon: results['daemon'],
  );
}

class GitAnalysisServer {
  HttpServer? _server;
  bool _running = false;

  Future<void> start({int port = 8080, bool daemon = false}) async {
    if (_server != null) return;

    var handler = const shelf.Pipeline()
        .addMiddleware(shelf.logRequests())
        .addHandler(_handleRequest);

    _server = await io.serve(handler, 'localhost', port);
    _running = true;
    print('Git分析服务器启动在: ${_server?.address.host}:${_server?.port}');

    if (daemon) {
      // 守护进程模式
      await _runAsDaemon();
    } else {
      // 交互模式
      await _runInteractive();
    }
  }

  Future<void> _runAsDaemon() async {
    ProcessSignal.sigint.watch().listen((_) => stop());
    ProcessSignal.sigterm.watch().listen((_) => stop());

    while (_running) {
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<void> _runInteractive() async {
    print('输入 "help" 查看可用命令');

    await for (String line in stdin
        .transform(const SystemEncoding().decoder)
        .transform(const LineSplitter())) {
      switch (line.trim().toLowerCase()) {
        case 'help':
          print('可用命令:');
          print('  status - 显示服务器状态');
          print('  stop   - 停止服务器');
          print('  help   - 显示此帮助');
          break;

        case 'status':
          print('服务器状态: ${_running ? "运行中" : "已停止"}');
          if (_running) {
            print('地址: ${_server?.address.host}:${_server?.port}');
          }
          break;

        case 'stop':
          await stop();
          return;

        default:
          print('未知命令。输入 "help" 查看可用命令');
      }
    }
  }

  Future<shelf.Response> _handleRequest(shelf.Request request) async {
    try {
      switch (request.url.path) {
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

          final analyzer = AICommitAnalyzer.fromPath(
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

          final analyzer = AIVersionAnalyzer.fromPath(projPath);
          final versions = await analyzer.tags();

          return shelf.Response.ok(versions.join(','));

        case 'version-analysis':
          final params = request.url.queryParameters;
          final projPath = params['projPath'];
          final version = params['version'];

          if (projPath == null) {
            return shelf.Response.badRequest(body: '项目路径不能为空');
          }

          final analyzer = AIVersionAnalyzer.fromPath(projPath);
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

  Future<void> stop() async {
    print('正在停止服务器...');
    await _server?.close();
    _server = null;
    _running = false;
    print('服务器已停止');
  }
}

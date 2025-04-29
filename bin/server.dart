import 'dart:io';
import 'package:args/args.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:logging/logging.dart';
import '../lib/app.dart';

void main(List<String> args) async {
  // 配置日志
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final logger = Logger('GitAnalysisServer');
  
  // 解析命令行参数
  final parser = ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '8080')
    ..addFlag('help', abbr: 'h', negatable: false)
    ..addFlag('daemon', abbr: 'd', negatable: false, help: '以守护进程模式运行');

  final results = parser.parse(args);

  if (results['help']) {
    print('使用方法: dart bin/server.dart [选项]');
    print(parser.usage);
    return;
  }

  final port = int.parse(results['port']);
  final app = App();

  // 启动服务器
  final server = await io.serve(app.handler, 'localhost', port);
  logger.info('Git分析服务器启动在: ${server.address.host}:${server.port}');

  // 处理进程信号
  ProcessSignal.sigint.watch().listen((_) async {
    logger.info('正在关闭服务器...');
    await server.close();
    exit(0);
  });

  if (!results['daemon']) {
    print('输入 Ctrl+C 停止服务器');
  }
}
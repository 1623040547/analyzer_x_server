///脚本文件，不应该被项目文件所引用
import 'dart:io';
import 'package:analyzer_query/tester.dart';

String? _modulePath;

void main() {
  final exportFiles = _exportCodeGen();
  _directiveReplace(exportFiles);
}

///生成模块导出代码
List<File> _exportCodeGen() {
  final path = Platform.script.path;
  final f = File(path);
  List<File> dartFiles = [];
  List<File> gDartFiles = [];
  for (var el in f.parent.listSync(recursive: true)) {
    if (el is! File) {
      continue;
    }
    if (el.path.endsWith('.g.dart')) {
      gDartFiles.add(el);
    } else if (el.path.endsWith('.dart')) {
      dartFiles.add(el);
    }
  }
  List<File> exportFiles = [];
  for (var dartFile in dartFiles) {
    final result = gDartFiles.where(
      (e) =>
          e.uri.pathSegments.last ==
          dartFile.uri.pathSegments.last.replaceFirst('.dart', '.g.dart'),
    );
    if (result.isNotEmpty) {
      exportFiles.add(dartFile);
    }
  }

  StringBuffer exportCode = StringBuffer();

  for (var exportFile in exportFiles) {
    exportCode.write(
        'export \'${exportFile.uri.path.replaceAll('${f.parent.path}/', '')}\';\n');
  }

  _modulePath = '${f.parent.path}/xxmodel.dart';
  File(_modulePath!).writeAsString(exportCode.toString());
  return exportFiles;
}

///将外部对模块的引用从单文件引用改为模块引用，需要使用到`analyzer_helper`插件
void _directiveReplace(List<File> exportFiles) {
  rootDart.acceptPack = (pack) => pack.name == 'analyzer_x_server';
  rootDart.acceptDartFile = (file) => !file.filePath.contains("lib/model");
  final List<DartFile> files = rootDart.flush();
  final appName = files.first.package.name;
  for (var f in files) {
    bool isFind = false;
    int point = 0;
    String text = f.fileString;
    TestFile.fromFile(
      f.filePath,
      breathVisit: true,
      visit: (node, token, controller) {
        if (node is ImportDirective) {
          DirectivePath path = DirectivePath(
            filePath: f.filePath,
            config: rootDart.config,
            handleLibrary: (String libName) {
              return "";
            },
            uriString: node.uri.stringValue ?? "",
          );
          final result = exportFiles.where((e) => e.path == path.path);
          if (result.isNotEmpty || _modulePath == path.path) {
            isFind = true;
            point = token.start;
            text = text.substring(0, token.start) +
                ' ' * token.name.length +
                text.substring(token.end);
          }
        }
        if (controller.depth > 2) {
          controller.stop();
        }
      },
    );

    if (isFind) {
      text =
          "${text.substring(0, point)}\nimport 'package:$appName/model/xxmodel.dart';\n${text.substring(point)}";
      text = DartFormatter().format(text);
      File(f.filePath).writeAsString(text);
    }
  }
}

import 'dart:io';

import 'package:analyzer_x/analyzer_x.dart';

import 'package:analyzer_x_server/model/xxmodel.dart';

class ProjectService {
  Future<ProjectModel?> buildProject(String path) async {
    final firstBuild = _buildProject(path);
    if (firstBuild != null) {
      return firstBuild;
    }
    try {
      final result = await Process.run(
        "flutter",
        ["pub", "get"],
        runInShell: true,
        workingDirectory: path,
      );
      if (result.exitCode != 1) {
        return null;
      }
    } catch (e) {
      return null;
    }
    return _buildProject(path);
  }

  ProjectModel? _buildProject(String path) {
    if (!PackageConfig.projExist(path)) {
      return null;
    }
    final projDart = ProjectDart(PackageConfig.fromProj(path));
    projDart.acceptPack = (pack) => pack.isPlugin || pack.isMainProj;
    projDart.flush();
    final rootProj = projDart.packages.where((p) => p.isMainProj).firstOrNull;
    if (rootProj == null) {
      return null;
    }
    final subProj = projDart.packages.where((p) => p.isPlugin);

    return ProjectModel(
      rootProj.packagePath,
      rootProj.name,
      subProj.map((e) => ProjectModel(e.packagePath, e.name, [])).toList(),
    );
  }
}

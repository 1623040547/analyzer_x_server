import 'package:analyzer_x_server/base/apix.dart';
import 'package:analyzer_x_server/model/xxmodel.dart';
import 'package:analyzer_x_server/module/project/project_service.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ProjectController {
  Router get router {
    final router = Router();

    // 提交信息分析
    router.post('/build', _handleProjectBuild);

    return router;
  }

  @ApiMeta(ProjectBuildParam, ProjectBuildResponse)
  Future<Response> _handleProjectBuild(Request request) async {
    try {
      final param = await request.postParam(ProjectBuildParam.fromJson);
      final model = await ProjectService().buildProject(param.folderPath);
      if (model == null) {
        return Response.badRequest(body: "FolderPath is not valid.");
      }
      return ResponseJson.ok(ProjectBuildResponse(model).toJson);
    } catch (e) {
      return Response.internalServerError(body: '生成提交信息失败: $e');
    }
  }
}

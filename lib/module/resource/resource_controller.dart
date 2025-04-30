import 'package:analyzer_x_server/base/apix.dart';

import 'package:analyzer_x_server/model/xxmodel.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'resource_service.dart';

class ResourceController {
  Router get router {
    final router = Router();

    router.post('/asset/add', _handleAssetAdd);

    return router;
  }

  @ApiMeta(AssetAddParam, AssetAddResponse)
  Future<Response> _handleAssetAdd(Request request) async {
    try {
      final param = await request.postParam(AssetAddParam.fromJson);
      final response = await ResourceService().addAsset(param);
      return ResponseJson.ok(response.toJson);
    } catch (e) {
      return Response.internalServerError(body: '生成提交信息失败: $e');
    }
  }
}

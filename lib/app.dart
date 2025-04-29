import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'controllers/git_controller.dart';
import 'controllers/health_controller.dart';

class App {
  Handler get handler {
    final router = Router();

    // 健康检查
    router.mount('/health', HealthController().router);
    
    // Git 分析相关接口
    router.mount('/git', GitController().router);

    // 404 处理
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('未找到请求的接口');
    });

    return Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(_handleCors())
        .addHandler(router);
  }

  Middleware _handleCors() {
    return createMiddleware(
      requestHandler: (Request request) {
        if (request.method == 'OPTIONS') {
          return Response.ok('', headers: _corsHeaders);
        }
        return null;
      },
      responseHandler: (Response response) {
        return response.change(headers: _corsHeaders);
      },
    );
  }

  final _corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, Content-Type',
  };
}
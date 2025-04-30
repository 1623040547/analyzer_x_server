import 'package:analyzer_x_server/module/project/project_controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'module/git/git_controller.dart';
import 'module/health/health_controller.dart';

class App {
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

extension AppHandler on App {
  Handler get handler {
    final router = Router();

    router.mount('/health', HealthController().router);
    router.mount('/git', GitController().router);
    router.mount('/project', ProjectController().router);

    router.all(
      '/<ignored|.*>',
      (Request request) => Response.notFound('未找到请求的接口'),
    );
    return Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(_handleCors())
        .addHandler(router);
  }
}

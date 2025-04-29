import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class HealthController {
  Router get router {
    final router = Router();
    
    router.get('/', (Request request) {
      return Response.ok('服务器运行正常');
    });
    
    return router;
  }
}
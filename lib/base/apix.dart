import 'dart:convert';

import 'package:shelf/shelf.dart';

class ApiMeta {
  final Type request;

  final Type response;

  const ApiMeta(
    this.request,
    this.response,
  );
}

extension RequestJson on Request {
  Future<T> postParam<T>(T Function(Map<String, dynamic>) fromJson) async {
    final jsonStr = await readAsString();
    return fromJson(json.decode(jsonStr) as Map<String, dynamic>);
  }

  Future<T> getParam<T>(T Function(Map<String, dynamic>) fromJson) async {
    final jsonStr = headers['body'] as String;
    return fromJson(json.decode(jsonStr) as Map<String, dynamic>);
  }
}

extension ResponseJson on Response {
  static ok(Map<String, dynamic> Function() toJson) => Response.ok(
        jsonEncode(toJson()),
        headers: {'Content-Type': 'application/json'},
      );
}

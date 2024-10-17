import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import './../../services/generic_service.dart';
import './../../api/api.dart';

class CollectionController extends Api {
  final GenericService service;

  CollectionController({
    required this.service,
  });

  FutureOr<Response> _findOne(Request req) async {
    final result = await service.findOne(req.params['id'] ?? '');
    return Response.ok(jsonEncode(result.toJson()));
  }

  @override
  Handler getHandler({List<Middleware> middlewares = const []}) {
    final router = Router();

    router.get(
      '/collection/<id>',
      createHandler(router: _findOne, middlewares: middlewares),
    );

    return router;
  }
}

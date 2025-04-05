import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import './../../services/generic_service.dart';
import './../../api/api.dart';
import '../../infra/failures/i_failures.dart';

class CollectionController extends Api {
  final GenericService service;

  CollectionController({
    required this.service,
  });

  FutureOr<Response> _findOne(Request req) async {
    final (result, failure) = await service.findOne(req.params['id'] ?? '');

    if (failure is Empty) {
      return Response.ok(jsonEncode(result.toJson()));
    } else if (failure is NotFoundFailure) {
      return Response.notFound(jsonEncode(failure.message));
    }

    return Response.forbidden(jsonEncode('Forbidden'));
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

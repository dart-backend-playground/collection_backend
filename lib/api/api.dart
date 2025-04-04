import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware> middlewares = const [],
  });

  createHandler({
    required Handler router,
    required List<Middleware> middlewares,
  }) {
    var pipeline = Pipeline();

    for (Middleware middleware in middlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }

    return pipeline.addHandler(router);
  }
}

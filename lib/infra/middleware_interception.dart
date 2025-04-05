import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  Map<String, Object> context = {};

  Middleware get headerMiddleware {
    return createMiddleware(responseHandler: (Response response) {
      response = response.change(
        headers: {
          'content-type': 'application/json',
        },
      );
      return response;
    });
  }

  Middleware get loginResponseMiddleware {
    return createMiddleware(responseHandler: (Response response) {
      response = response.change(headers: {
        'content-type': 'application/json',
      });

      return response;
    });
  }
}

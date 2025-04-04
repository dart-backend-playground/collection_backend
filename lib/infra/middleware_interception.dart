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

  // Middleware get authorizationRequestHandler {
  //   return (Handler handler) {
  //     return (Request request) async {
  //       request = request.change(
  //         headers: {
  //           'Authorization': 'Bearer ${context['accessToken']}',
  //         },
  //       );
  //       return handler(request);
  //     };
  //   };
  // }

  Middleware get loginResponseMiddleware {
    return createMiddleware(responseHandler: (Response response) {
      context = response.context;

      return response;
    });
  }
}

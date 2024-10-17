import 'dart:async';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import './../../infra/security/i_security_service.dart';
import './../../infra/failures/jwt_failure.dart';
import './../../api/api.dart';

class LoginController extends Api {
  final ISecurityService service;

  LoginController({required this.service});

  FutureOr<Response> _login(Request req) async {
    final (email, password) = switch (req.headers) {
      {
        'email': String email,
        'password': String password,
      } =>
        (email, password),
      _ => ('', ''),
    };

    if (email.isNotEmpty && password.isNotEmpty) {
      final token = await service.login(email, password);
      final (JWT jwtValidate, failure) = await service.validateJWT(token);

      if (failure is JwtFailure) {
        return Response.internalServerError(body: failure.message);
      }

      return Response.ok(
        '',
        context: {'accessToken': token},
      );
    }

    return Response.forbidden('User Not found');
  }

  @override
  Handler getHandler({List<Middleware> middlewares = const []}) {
    final router = Router();

    router.get('/login', createHandler(router: _login, middlewares: middlewares));

    return router;
  }
}

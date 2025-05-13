import 'dart:async';

import 'package:collection_backend/infra/failures/i_failures.dart';
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
      final failure = await service.validateJWT(token);

      if (failure is JwtFailure) {
        return Response.internalServerError(body: failure.message);
      }

      return Response.ok(
        '{accessToken: $token}',
      );
    }

    return Response.forbidden('User Not found');
  }

  FutureOr<Response> _logout(Request req) async {
    final (accessToken) = switch (req.headers) {
      {
        'access_token': String accessToken,
      } =>
        (accessToken),
      _ => (''),
    };

    final failure = await service.logout(accessToken);

    if (failure is Empty) {
      return Response.ok(
        '{logout: ok}',
      );
    }

    return Response.internalServerError(body: 'erro');
  }

  FutureOr<Response> _register(Request req) async {
    final (email, password) = switch (req.headers) {
      {
        'email': String email,
        'password': String password,
      } =>
        (email, password),
      _ => ('', ''),
    };

    if (email.isNotEmpty && password.isNotEmpty) {
      final token = await service.register(email, password);
      final failure = await service.validateJWT(token);

      if (failure is JwtFailure) {
        return Response.internalServerError(body: failure.message);
      }

      return Response.ok(
        '{accessToken: $token}',
      );
    }

    return Response.forbidden('User Not found');
  }

  @override
  Handler getHandler({List<Middleware> middlewares = const []}) {
    final router = Router();

    router.post(
        '/login', createHandler(router: _login, middlewares: middlewares));
    router.post(
        '/logout', createHandler(router: _logout, middlewares: middlewares));
    router.post('/register',
        createHandler(router: _register, middlewares: middlewares));

    return router;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:collection_backend/dao/user_login_dao.dart';
import 'package:collection_backend/models/user_login_model.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import './i_security_service.dart';
import './../failures/i_failures.dart';
import './../failures/jwt_failure.dart';

final bearerTokenRegExp = RegExp(r'Bearer (?<token>.+)');

class SecurityService extends ISecurityService<JWT, IFailure> {
  final UserLoginDao loginDao;

  SecurityService({required this.loginDao});

  @override
  Future<String> login(String email, password) async {
    final (user, failure) = await loginDao.login(
      UserLoginModel(login: email, password: password),
    );

    if (failure is Empty) {
      return user.accessToken;
    }
    return 'jwt_invalid_token';
  }

  @override
  Future<IFailure> logout(String accessToken) async {
    final failure = await loginDao.logout(accessToken);

    return failure;
  }

  @override
  Future<String> register(String email, password) async {
    final (user, failure) = await loginDao.register(
      UserLoginModel(login: email, password: password),
    );

    if (failure is Empty) {
      return user.accessToken;
    }

    return 'Cannot register';
  }

  @override
  Future<IFailure> validateJWT(String token) async {
    try {
      JWT.verify(
        token,
        SecretKey(Platform.environment['JWT_KEY'] ??
            (throw StateError('JWT_KEY environment variable not provided'))),
      );
      return Empty();
    } on JWTException catch (e) {
      return JwtFailure(message: 'Error: ${e.message}');
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request request) async {
        final authorizationHeader =
            request.headers[HttpHeaders.authorizationHeader] ?? '';

        final token = bearerTokenRegExp.firstMatch(authorizationHeader);

        if (token == null) {
          return Response.unauthorized('Access Token not informed');
        } else {
          final failure = await validateJWT(token[1]!);

          if (failure is Empty) {
            return handler(request);
          } else if (failure is JwtFailure) {
            return Response.unauthorized('Invalid Token');
          }
        }

        return Response.unauthorized('Unauthorization');
      };
    };
  }
}

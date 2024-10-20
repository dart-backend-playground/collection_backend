import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import './i_security_service.dart';
import './../failures/i_failures.dart';
import './../failures/jwt_failure.dart';
import '../database/supabase_database_connection.dart';

final bearerTokenRegExp = RegExp(r'Bearer (?<token>.+)');

class SecurityService extends ISecurityService<JWT, IFailure> {
  final SupabaseDatabaseConnection supabase;

  SecurityService({required this.supabase});

  @override
  Future<String> login(String email, password) async {
    final AuthResponse res = await supabase.supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = res.session;

    if (session != null) {
      return session.accessToken;
    }

    return '';
  }

  @override
  Future<(JWT, IFailure)> validateJWT(String token) async {
    try {
      return (
        JWT.verify(
          token,
          SecretKey(Platform.environment['JWT_KEY'] ?? ''),
        ),
        Empty()
      );
    } on JWTException {
      return (JWT({}), JwtFailure(message: 'Error: JWTException'));
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request request) async {
        final authorizationHeader = request.headers[HttpHeaders.authorizationHeader] ?? '';

        final token = bearerTokenRegExp.firstMatch(authorizationHeader);

        if (token != null) {
          final (jwtValidate, failure) = await validateJWT(token[1]!);
          if (failure is Empty) {
            // request = request.change(
            //   context: {
            //     'userId': userId,
            //   },
            // );
            return handler(request);
          } else if (failure is JwtFailure) {}
        }

        return Response.unauthorized('Unauthorization');
      };
    };
  }
}

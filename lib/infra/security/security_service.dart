import 'dart:convert';
import 'dart:io';

import 'package:collection_backend/infra/database/supabase_database_connection.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import './i_security_service.dart';
import './../failures/i_failures.dart';
import './../failures/jwt_failure.dart';

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

    return jsonEncode('');
  }

  @override
  Future<String> logout() async {
    await supabase.supabase.auth.signOut();

    return jsonEncode('Logout');
  }

  @override
  Future<String> register(String email, password) async {
    final AuthResponse res = await supabase.supabase.auth.signUp(
      email: email,
      password: password,
    );
    final Session? session = res.session;

    if (session != null) {
      return session.accessToken;
    }

    return jsonEncode('Error: Cannot SignUp');
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

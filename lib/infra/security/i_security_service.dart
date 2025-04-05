import 'package:shelf/shelf.dart';

abstract class ISecurityService<T, U> {
  Future<String> login(String email, password);
  Future<String> logout();
  Future<String> register(String email, password);
  Future<U> validateJWT(String token);

  Middleware get authorization;
}

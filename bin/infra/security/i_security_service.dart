import 'package:shelf/shelf.dart';

abstract class ISecurityService<T, U> {
  Future<String> login(String email, password);
  Future<(T, U)> validateJWT(String token);

  Middleware get authorization;
}

import './i_failures.dart';

class JwtFailure implements IFailure {
  final String message;

  JwtFailure({required this.message});
}

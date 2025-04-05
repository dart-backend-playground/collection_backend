import 'i_failures.dart';

class DatabaseFailure implements IFailure {
  final String message;

  const DatabaseFailure({this.message = ''});
}

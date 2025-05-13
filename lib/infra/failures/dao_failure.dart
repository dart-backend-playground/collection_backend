import 'package:collection_backend/infra/failures/i_failures.dart';

class DaoFailure implements IFailure {
  final String message;

  const DaoFailure({this.message = ''});
}

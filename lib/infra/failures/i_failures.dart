abstract interface class IFailure {}

class Empty implements IFailure {}

class NotFoundFailure implements IFailure {
  final String message;

  const NotFoundFailure({this.message = ''});
}

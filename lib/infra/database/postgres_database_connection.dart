import 'package:postgres/postgres.dart';

import '../../utils/types.dart';
import '../failures/i_failures.dart';
import 'i_database_connection.dart';

class PostgresDatabaseConnection extends IDatabaseConnection {
  late final Connection connection;

  PostgresDatabaseConnection() {
    connect();
  }

  Future<void> connect() async {
    final username = Platform.environment['DB_USER'] ??
        (throw DatabaseFailure(
            message: 'DB_USERNAME environment variable not provided'));
    final host = Platform.environment['DB_HOST'] ??
        (throw DatabaseFailure(
            message: 'DB_HOST environment variable not provided'));
    final database = Platform.environment['DB_NAME'] ??
        (throw DatabaseFailure(
            message: 'DB_NAME environment variable not provided'));
    final port = int.parse(Platform.environment['DB_PORT'] ??
        (throw DatabaseFailure(
            message: 'DB_PORT environment variable not provided')));
    final password = Platform.environment['DB_PASSWORD'] ??
        (throw DatabaseFailure(
            message: 'DB_PASSWORD environment variable not provided'));

    connection = await Connection.open(Endpoint(
      host: host,
      database: database,
      port: port,
      username: username,
      password: password,
    ));
  }

  @override
  Future<(List<JsonType>, IFailure)> delete(String table, WhereType where) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<(List<JsonType>, IFailure)> insert(String table, ColumnType columns) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<(List<JsonType>, IFailure)> select(String table, ColumnsSelectType columns, WhereType where) async {
    final result = await connection.execute('select ${columns.join(',')} from $table ;');
    print(result.first.toColumnMap());
    throw UnimplementedError();
  }

  @override
  Future<(List<JsonType>, IFailure)> update(String table, ColumnType columns, WhereType where) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

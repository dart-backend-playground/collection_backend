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
    connection = await Connection.open(Endpoint(
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

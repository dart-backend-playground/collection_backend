import '../../utils/types.dart';
import '../../infra/failures/i_failures.dart';

abstract class IDatabaseConnection {
  Future<(List<JsonType>, IFailure)> insert(String table, ColumnType columns);
  Future<(List<JsonType>, IFailure)> select(String table, ColumnsSelectType columns, WhereType where);
  Future<(List<JsonType>, IFailure)> update(String table, ColumnType columns, WhereType where);
  Future<(List<JsonType>, IFailure)> delete(String table, WhereType where);
}

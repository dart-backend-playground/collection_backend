import 'package:supabase/supabase.dart';

import '../../utils/types.dart';
import '../failures/i_failures.dart';
import 'i_database_connection.dart';

class SupabaseDatabaseConnection extends IDatabaseConnection {
  late final SupabaseClient supabase;
  // @override
  // Future<Object> createConnection() async {
  //   supabase = SupabaseClient(
  //     'https://poiemvrodruxjueyykwl.supabase.co',
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBvaWVtdnJvZHJ1eGp1ZXl5a3dsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU3NTU5NDUsImV4cCI6MjA0MTMzMTk0NX0.ezNwE6JCwQiqq2de4Z-tgQZWg2ftzoCiNi5i5FpdJL8',
  //   );
  //   return supabase;
  // }

  SupabaseDatabaseConnection() {
    supabase = SupabaseClient(
      'https://poiemvrodruxjueyykwl.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBvaWVtdnJvZHJ1eGp1ZXl5a3dsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU3NTU5NDUsImV4cCI6MjA0MTMzMTk0NX0.ezNwE6JCwQiqq2de4Z-tgQZWg2ftzoCiNi5i5FpdJL8',
      authOptions: AuthClientOptions(
        authFlowType: AuthFlowType.implicit,
        // autoRefreshToken: true,
        // pkceAsyncStorage: SecureLocalStorage(storage),
      ),
    );
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
    String convertedWhere = '';

    where.forEach((key, value) {
      convertedWhere += convertedWhere.isEmpty ? '' : ',';
      convertedWhere += '$key.in.(${value.join(',')})';
    });

    return (
      await supabase
          .from(table)
          .select(columns.join(','))
          .filter(where.keys.first, 'eq', where.values.first.first.toString()),
      // .inFilter('description', ['xurumingo']),
      Empty()
    );
  }

  @override
  Future<(List<JsonType>, IFailure)> update(String table, ColumnType columns, WhereType where) {
    // TODO: implement update
    throw UnimplementedError();
  }

  // @override
  // IDatabaseConnection select(List<String> fields) {
  //   _fields = fields;
  //   return this;
  // }

  // @override
  // IDatabaseConnection from(String table) {
  //   _table = table;
  //   return this;
  // }

  // @override
  // Future<List<Map<String, dynamic>>> where(List<String> fields, List<String> values) {
  //   assert(fields.length == values.length, 'Fields must have same lenght of values');

  //   Map<String, Object> where = {};

  //   for (var i = 0; i < fields.length; i++) {
  //     where[fields[i]] = values[i];
  //   }
  //   return supabase.from(_table).select(_fields.toString()).match(where);
  // }
}

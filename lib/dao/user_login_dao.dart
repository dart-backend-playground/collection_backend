import '../models/user_login_model.dart';
import '../infra/database/i_dao.dart';
import '../infra/database/i_database_connection.dart';
import '../infra/failures/i_failures.dart';

class UserLoginDao extends IDAO<UserLoginModel, IFailure> {
  final IDatabaseConnection database;

  UserLoginDao({required this.database});

  @override
  Future<(bool, IFailure)> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<(List<UserLoginModel>, IFailure)> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<(UserLoginModel, IFailure)> findOne(String id) async {
    // final data = database.select(['']).from('');

    return (UserLoginModel(login: '', password: 'description'), Empty());
  }

  @override
  Future<(bool, IFailure)> save(UserLoginModel value) {
    // final data = database.update(table, columns, where)
    throw UnimplementedError();
  }
}

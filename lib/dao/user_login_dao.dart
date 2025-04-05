import '../models/user_login_model.dart';
import '../infra/database/i_dao.dart';
import '../infra/database/i_database_connection.dart';
import '../infra/failures/i_failures.dart';

class UserLoginDao extends IDAO<UserLoginModel, IFailure> {
  final IDatabaseConnection database;

  UserLoginDao({required this.database});

  @override
  Future<IFailure> delete(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<(List<UserLoginModel>, IFailure)> findAll() async {
    throw UnimplementedError();
  }

  @override
  Future<(UserLoginModel, IFailure)> findOne(String id) async {
    // final data = database.select(['']).from('');

    return (UserLoginModel(login: '', password: 'description'), Empty());
  }

  @override
  Future<IFailure> save(UserLoginModel value) async {
    // final data = database.update(table, columns, where)
    throw UnimplementedError();
  }
}

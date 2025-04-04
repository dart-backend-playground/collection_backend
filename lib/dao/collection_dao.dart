import '../infra/database/i_dao.dart';
import '../infra/database/i_database_connection.dart';
import '../infra/failures/i_failures.dart';
import '../infra/failures/jwt_failure.dart';
import '../models/collection_model.dart';
import '../models/collection_type_model.dart';

class CollectionDao implements IDAO<CollectionModel, IFailure> {
  final IDatabaseConnection database;

  CollectionDao({required this.database});

  @override
  Future<(bool, IFailure)> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<(List<CollectionModel>, IFailure)> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<(CollectionModel, IFailure)> findOne(String id) async {
    // final listResult =
    //     await database.select(['*']).from('teste').where(['id'], [id]);
    // final result = listResult.first;
    final (listResult, failure) = await database.select(
      'teste',
      ['*'],
      {
        'id': [id],
      },
    );

    if (failure is Empty) {
      // print(listResult.toString());
      final result = listResult.first;
      return (
        CollectionModel(
          id: result['id'].toString(),
          name: result['description'].toString(),
          description: '',
          creationDate: DateTime.now(),
          changeDate: DateTime.now(),
          type: CollectionTypeModel.empty(),
        ),
        Empty()
      );
    }

    return (CollectionModel.empty(), JwtFailure(message: 'Collection not found'));
    // final result = listResult
  }

  @override
  Future<(bool, IFailure)> save(CollectionModel value) {
    // TODO: implement save
    throw UnimplementedError();
  }
}

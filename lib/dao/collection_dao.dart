import '../infra/database/i_dao.dart';
import '../infra/database/i_database_connection.dart';
import '../infra/failures/i_failures.dart';
import '../models/collection_model.dart';
import '../models/collection_type_model.dart';

class CollectionDao implements IDAO<CollectionModel, IFailure> {
  final IDatabaseConnection database;

  CollectionDao({required this.database});

  @override
  Future<IFailure> delete(String id) async {
    final (listResult, failure) = await database.delete(
      'tb_collection',
      {
        'id': [id],
      },
    );

    return failure;
  }

  @override
  Future<(List<CollectionModel>, IFailure)> findAll() async {
    final (listResult, failure) = await database.select('tb_collection', ['*'], {});

    if ((failure is Empty) && (listResult.isNotEmpty)) {
      return (
        listResult.map((e) {
          return CollectionModel.fromJson(e);
        }).toList(),
        Empty()
      );
    }

    return (<CollectionModel>[], failure);
  }

  @override
  Future<(CollectionModel, IFailure)> findOne(String id) async {
    final (listResult, failure) = await database.select(
      'tb_collection',
      ['*'],
      {
        'id': [id],
      },
    );

    if ((failure is Empty) && (listResult.isNotEmpty)) {
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

    return (CollectionModel.empty(), failure);
  }

  @override
  Future<IFailure> save(CollectionModel value) async {
    final (listResult, failure) = await database.insert(
      'tb_collection',
      value.toJson().cast<String, String>(),
    );
    return failure;
  }
}

import '../infra/database/i_dao.dart';
import '../infra/failures/i_failures.dart';
import './../models/collection_model.dart';
import './generic_service.dart';

class CollectionService extends GenericService<CollectionModel> {
  final IDAO<CollectionModel, IFailure> dao;

  CollectionService({required this.dao});

  @override
  bool delete(String id) {
    final failure = dao.delete(id);

    return failure is Empty;
  }

  @override
  Future<List<CollectionModel>> findAll() async {
    final (dados, failure) = await dao.findAll();
    if (failure is Empty) {
      return dados;
    }

    return <CollectionModel>[];
  }

  @override
  Future<CollectionModel> findOne(String id) async {
    final (dados, failure) = await dao.findOne(id);
    if (failure is Empty) {
      return dados;
    }

    return CollectionModel.empty();
  }

  @override
  bool save(CollectionModel object) {
    final failure = dao.save(object);

    return failure is Empty;
  }
}

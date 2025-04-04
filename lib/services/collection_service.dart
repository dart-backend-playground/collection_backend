import './../models/collection_model.dart';
import './generic_service.dart';
import '../infra/database/i_dao.dart';
import '../infra/failures/i_failures.dart';

class CollectionService extends GenericService<CollectionModel> {
  final IDAO dao;

  CollectionService({required this.dao});

  @override
  bool delete(String id) {
    throw UnimplementedError();
  }

  @override
  List<CollectionModel> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
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
    // TODO: implement save
    throw UnimplementedError();
  }
}

abstract class GenericService<T, U> {
  Future<(T, U)> findOne(String id);
  Future<List<T>> findAll();
  bool save(T object);
  bool delete(String id);
}

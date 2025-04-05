abstract class GenericService<T> {
  Future<T> findOne(String id);
  Future<List<T>> findAll();
  bool save(T object);
  bool delete(String id);
}

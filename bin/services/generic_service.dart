abstract class GenericService<T> {
  Future<T> findOne(String id);
  List<T> findAll();
  bool save(T object);
  bool delete(String id);
}

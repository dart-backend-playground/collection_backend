abstract class IDAO<T, U> {
  Future<(T, U)> findOne(String id);
  Future<(List<T>, U)> findAll();
  Future<U> save(T value);
  Future<U> delete(String id);
}

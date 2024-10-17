abstract class IDAO<T, U> {
  Future<(T, U)> findOne(String id);
  Future<(List<T>, U)> findAll();
  Future<(bool, U)> delete(String id);
  Future<(bool, U)> save(T value);
}

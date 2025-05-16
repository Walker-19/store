abstract class StorageService<T> {
 final String key;

  StorageService({required this.key});



  Future<void> save(T data);


  Future<T?> load();
  
}
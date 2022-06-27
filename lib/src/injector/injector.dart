/// Function to receive dependency to inject
typedef CDependencyInjectorBuilder<T> = T Function(CInjector injector);

/// Function to receive dependency to inject
typedef CDependencyInjectorAsyncBuilder<T> = Future<T> Function(
  CInjector injector,
);

/// Interface responsible to manager dependency injector
abstract class CInjector {
  /// Method used to register dependency by lazy
  void registerLazySingleton<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
  });

  /// Method used to register dependency by factory
  void registerFactory<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
  });

  /// Method used to register singleton dependency
  void registerSingleton<T extends Object>(
    T value, {
    String? dependencyName,
  });

  /// Method used to register dependency async
  void registerFactoryAsync<T extends Object>(
    CDependencyInjectorAsyncBuilder<T> builder, {
    String? dependencyName,
  });

  /// Method used to register dependency async
  void registerSingletonAsync<T extends Object>(
    CDependencyInjectorAsyncBuilder<T> builder, {
    String? dependencyName,
  });

  /// Method used to get dependency
  T get<T extends Object>({String? dependencyName});

  /// Method used to get dependency async
  Future<T> getAsync<T extends Object>({String? dependencyName});

  /// Method used to reset dependencies registered
  Future<void> reset({bool dispose = false});
}

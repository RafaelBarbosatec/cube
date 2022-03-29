/// Enum that represents types of the register
enum DependencyRegisterType { factory, singleton, lazySingleton }

/// Function to receive dependency to inject
typedef CDependencyInjectorBuilder<T> = T Function(CInjector injector);

/// Function to receive dependency to inject
typedef CDependencyInjectorAsyncBuilder<T> = Future<T> Function(
  CInjector injector,
);

/// Interface responsible to manager dependency injector
abstract class CInjector {
  /// Method used to register dependency by lazy
  void putLazySingleton<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
  });

  /// Method used to register dependency by factory
  void putFactory<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
  });

  /// Method used to register singleton dependency
  void putSingleton<T extends Object>(
    T value, {
    String? dependencyName,
  });

  /// Method used to register dependency async
  void putDependencyAsync<T extends Object>(
    CDependencyInjectorAsyncBuilder<T> builder, {
    String? dependencyName,
    DependencyRegisterType type = DependencyRegisterType.factory,
  });

  /// Method used to get dependency
  T get<T extends Object>({String? dependencyName});

  /// Method used to get dependency async
  Future<T> getAsync<T extends Object>({String? dependencyName});

  /// Method used to reset dependencies registered
  Future<void> reset({bool dispose = false});
}

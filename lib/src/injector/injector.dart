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
  /// Method used to register dependency
  void putDependency<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
    DependencyRegisterType type = DependencyRegisterType.factory,
  });

  /// Method used to register dependency async
  void putDependencyAsync<T extends Object>(
    CDependencyInjectorAsyncBuilder<T> builder, {
    String? dependencyName,
    DependencyRegisterType type = DependencyRegisterType.factory,
  });

  /// Method used to get dependency
  T getDependency<T extends Object>({String? dependencyName});

  /// Method used to get dependency async
  Future<T> getDependencyAsync<T extends Object>({String? dependencyName});

  /// Method used to reset dependencies registered
  void reset({bool dispose = false});
}

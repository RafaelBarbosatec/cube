import '../cube.dart';

/// Function to receive Cube to inject
typedef CCubeInjectorBuilder<T extends Cube> = T Function(CInjector injector);

/// Function to receive dependency to inject
typedef CDependencyInjectorBuilder<T> = T Function(CInjector injector);

/// Interface responsible to manager dependency injector
abstract class CInjector {
  /// Method used to register dependency
  void registerDependency<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
    bool isSingleton = false,
  });

  /// Method used to get dependency
  T getDependency<T extends Object>({String? dependencyName});

  /// Method used to reset dependencies registered
  void reset();
}

import 'package:cubes/src/cube.dart';

typedef T CubeInjectorBuilder<T extends Cube>(CInjector injector);
typedef T DependencyInjectorBuilder<T>(CInjector injector);

abstract class CInjector {
  /// Method used to register dependency
  void registerDependency<T>(DependencyInjectorBuilder<T> builder, {String dependencyName, bool isSingleton = false});

  /// Method used to get dependency
  T getDependency<T>({String dependencyName});

  /// Method used to reset dependencies registered
  void reset();
}

import 'package:cubes/src/cube.dart';

typedef T CCubeInjectorBuilder<T extends Cube>(CInjector injector);
typedef T CDependencyInjectorBuilder<T>(CInjector injector);

abstract class CInjector {
  /// Method used to register dependency
  void registerDependency<T>(CDependencyInjectorBuilder<T> builder, {String dependencyName, bool isSingleton = false});

  /// Method used to get dependency
  T getDependency<T>({String dependencyName});

  /// Method used to reset dependencies registered
  void reset();
}

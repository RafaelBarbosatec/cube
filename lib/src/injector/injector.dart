import 'package:cubes/src/cube.dart';

typedef T CubeInjectorBuilder<T extends Cube>(CInjector injector);
typedef T DependencyInjectorBuilder<T>(CInjector injector);

abstract class CInjector {
  void registerDependency<T>(DependencyInjectorBuilder<T> builder, {String dependencyName, bool isSingleton = false});
  T getDependency<T>({String dependencyName});
  void reset();
}

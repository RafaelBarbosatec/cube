import 'package:cubes/src/cube.dart';

typedef T CubeInjectorBuilder<T extends Cube>(Injector injector);
typedef T DependencyInjectorBuilder<T>(Injector injector);

abstract class Injector {
  void registerDependency<T>(DependencyInjectorBuilder<T> builder, {String dependencyName, bool isSingleton = false});
  T getDependency<T>({String dependencyName});
}

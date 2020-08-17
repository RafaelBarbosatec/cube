import 'package:cubes/src/cube.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

typedef T CubeInjector<T extends Cube>(GetIt injector);
typedef T DependencyInjector<T>(GetIt injector);

registerCube<C extends Cube>(CubeInjector<C> cubeBuilder) {
  _getIt.registerFactory<C>(() => cubeBuilder(_getIt));
}

registerDependency<T>(DependencyInjector<T> builder, {String dependencyName}) {
  _getIt.registerFactory(
    () => builder(_getIt),
    instanceName: dependencyName,
  );
}

registerSingletonDependency<T>(DependencyInjector<T> builder,
    {String dependencyName}) {
  _getIt.registerLazySingleton(
    () => builder(_getIt),
    instanceName: dependencyName,
  );
}

T getDependency<T>({String dependencyName}) {
  return _getIt.get<T>(instanceName: dependencyName);
}

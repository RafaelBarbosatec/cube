import 'package:cubes/src/cube.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

typedef T CubeInjector<T extends Cube>(GetIt injector);
typedef T DependencyInjector<T>(GetIt injector);

// registers cubes
registerCube<C extends Cube>(CubeInjector<C> cubeBuilder) {
  _getIt.registerFactory<C>(() => cubeBuilder(_getIt));
}

// registers dependency of type Factory
registerDependency<T>(DependencyInjector<T> builder, {String dependencyName}) {
  _getIt.registerFactory(
    () => builder(_getIt),
    instanceName: dependencyName,
  );
}

// registers dependency of type singleton
registerSingletonDependency<T>(DependencyInjector<T> builder,
    {String dependencyName}) {
  _getIt.registerLazySingleton(
    () => builder(_getIt),
    instanceName: dependencyName,
  );
}

// get any dependency registered
T getDependency<T>({String dependencyName}) {
  return _getIt.get<T>(instanceName: dependencyName);
}

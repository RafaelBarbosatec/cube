import 'package:cubes/src/cube.dart';
import 'package:get_it/get_it.dart';

typedef T CubeInjectorBuilder<T extends Cube>(GetIt injector);
typedef T DependencyInjectorBuilder<T>(GetIt injector);

// // registers cubes
// registerCube<C extends Cube>(CubeInjector<C> cubeBuilder, {bool isSingleton = false}) {
//   if (isSingleton) {
//     _getIt.registerLazySingleton<C>(() => cubeBuilder(_getIt));
//   } else {
//     _getIt.registerFactory<C>(() => cubeBuilder(_getIt));
//   }
// }
//
// // registers dependency of type Factory
// registerDependency<T>(DependencyInjector<T> builder, {String dependencyName, bool isSingleton = false}) {
//   if (isSingleton) {
//     _getIt.registerLazySingleton(
//       () => builder(_getIt),
//       instanceName: dependencyName,
//     );
//   } else {
//     _getIt.registerFactory(
//       () => builder(_getIt),
//       instanceName: dependencyName,
//     );
//   }
// }
//
// // get any dependency registered
// T getDependency<T>({String dependencyName}) {
//   return _getIt.get<T>(instanceName: dependencyName);
// }
//
// // get any Cube registered
// T getCube<T extends Cube>() {
//   return _getIt.get<T>();
// }

abstract class Injector {
  void registerDependency<T>(DependencyInjectorBuilder<T> builder, {String dependencyName, bool isSingleton = false});
  T getDependency<T>({String dependencyName});
}

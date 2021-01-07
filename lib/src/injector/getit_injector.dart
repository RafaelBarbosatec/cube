import 'package:cubes/src/injector/injector.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

class GetItInjector extends CInjector {
  @override
  T getDependency<T>({String dependencyName}) {
    return _getIt.get<T>();
  }

  @override
  void registerDependency<T>(DependencyInjectorBuilder<T> builder, {String dependencyName, bool isSingleton = false}) {
    if (isSingleton) {
      _getIt.registerLazySingleton<T>(() => builder(this));
    } else {
      _getIt.registerFactory<T>(() => builder(this));
    }
  }

  @override
  void reset() {
    _getIt.reset(dispose: false);
  }
}

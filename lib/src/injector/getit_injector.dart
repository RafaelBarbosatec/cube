import 'package:get_it/get_it.dart';

import 'injector.dart';

final _getIt = GetIt.instance;

/// CInjector implemented with GetIt
class GetItInjector extends CInjector {
  @override
  T getDependency<T>({String dependencyName}) {
    return _getIt.get<T>(instanceName: dependencyName);
  }

  @override
  void registerDependency<T>(CDependencyInjectorBuilder<T> builder,
      {String dependencyName, bool isSingleton = false}) {
    if (isSingleton) {
      _getIt.registerLazySingleton<T>(() => builder(this),
          instanceName: dependencyName);
    } else {
      _getIt.registerFactory<T>(() => builder(this),
          instanceName: dependencyName);
    }
  }

  @override
  void reset() {
    _getIt.reset(dispose: false);
  }
}

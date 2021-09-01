import 'package:get_it/get_it.dart';

import 'injector.dart';

final _getIt = GetIt.instance;

/// CInjector implemented with GetIt
class GetItInjector extends CInjector {
  @override
  T getDependency<T extends Object>({String? dependencyName}) {
    return _getIt.get<T>(instanceName: dependencyName);
  }

  @override
  void registerDependency<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
    DependencyRegisterType type = DependencyRegisterType.factory,
  }) {
    switch (type) {
      case DependencyRegisterType.factory:
        _getIt.registerFactory<T>(
          () => builder(this),
          instanceName: dependencyName,
        );
        break;
      case DependencyRegisterType.singleton:
        _getIt.registerSingleton<T>(
          builder(this),
          instanceName: dependencyName,
        );
        break;
      case DependencyRegisterType.lazySingleton:
        _getIt.registerLazySingleton<T>(
          () => builder(this),
          instanceName: dependencyName,
        );
        break;
    }
  }

  @override
  void reset({bool dispose = false}) {
    _getIt.reset(dispose: dispose);
  }

  @override
  void registerDependencyAsync<T extends Object>(
    CDependencyInjectorAsyncBuilder<T> builder, {
    String? dependencyName,
    DependencyRegisterType type = DependencyRegisterType.factory,
  }) {
    switch (type) {
      case DependencyRegisterType.factory:
        _getIt.registerFactoryAsync<T>(
          () => builder(this),
          instanceName: dependencyName,
        );
        break;
      case DependencyRegisterType.singleton:
        _getIt.registerLazySingletonAsync<T>(
          () => builder(this),
          instanceName: dependencyName,
        );
        break;
      case DependencyRegisterType.lazySingleton:
        _getIt.registerSingletonAsync<T>(
          () => builder(this),
          instanceName: dependencyName,
        );
        break;
    }
  }

  @override
  Future<T> getDependencyAsync<T extends Object>({String? dependencyName}) {
    return _getIt.getAsync<T>(instanceName: dependencyName);
  }
}

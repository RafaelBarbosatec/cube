import 'package:get_it/get_it.dart';

import 'injector.dart';

final _getIt = GetIt.instance;

/// CInjector implemented with GetIt
class GetItInjector extends CInjector {
  @override
  void putDependencyAsync<T extends Object>(
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
  T get<T extends Object>({String? dependencyName}) {
    return _getIt.get<T>(instanceName: dependencyName);
  }

  @override
  Future<T> getAsync<T extends Object>({String? dependencyName}) {
    return _getIt.getAsync<T>(instanceName: dependencyName);
  }

  @override
  Future<void> reset({bool dispose = false}) {
    return _getIt.reset(dispose: dispose);
  }

  @override
  void registerFactory<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
  }) {
    _getIt.registerFactory<T>(
      () => builder(this),
      instanceName: dependencyName,
    );
  }

  @override
  void registerLazySingleton<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
  }) {
    _getIt.registerLazySingleton<T>(
      () => builder(this),
      instanceName: dependencyName,
    );
  }

  @override
  void registerSingleton<T extends Object>(T value, {String? dependencyName}) {
    _getIt.registerSingleton<T>(
      value,
      instanceName: dependencyName,
    );
  }
}

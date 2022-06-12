library cube;

import 'package:flutter/widgets.dart';

import 'src/cube.dart';
import 'src/injector/get_it_injector.dart';
import 'src/injector/injector.dart';
import 'src/util/cube_provider.dart';

export 'package:cubes/src/actions/cube_action.dart';
export 'package:cubes/src/cube.dart';
export 'package:cubes/src/feedback_manager/feedback_manager.dart';
export 'package:cubes/src/injector/injector.dart';
export 'package:cubes/src/observable/observable_list.dart';
export 'package:cubes/src/observable/observable_value.dart';
export 'package:cubes/src/util/cube_navigation_mixin.dart';
export 'package:cubes/src/util/cube_provider.dart';
export 'package:cubes/src/util/extensions/ext.dart';
export 'package:cubes/src/util/functions.dart';
export 'package:cubes/src/util/state_mixin.dart';
export 'package:cubes/src/widgets/animated_list_cube.dart';
export 'package:cubes/src/widgets/cube_consumer.dart';
export 'package:cubes/src/widgets/cube_widget.dart';
export 'package:cubes/src/widgets/text_form_field.dart';

/// Core of the package where you will have useful functions and settings
class Cubes {
  /// instance of the Cubes
  static final Cubes _instance = Cubes._internal();
  CInjector _injector = GetItInjector();

  Cubes._internal();

  /// Factory to get instance of the Cubes
  factory Cubes() {
    return _instance;
  }

  /// Use to get dependency registered
  static T get<T extends Object>({String? dependencyName}) {
    return _instance._injector.get<T>(dependencyName: dependencyName);
  }

  /// Use to get dependency registered by async
  static Future<T> getAsync<T extends Object>({String? dependencyName}) {
    return _instance._injector.getAsync<T>(dependencyName: dependencyName);
  }

  /// Method used to register dependency by lazy
  static void registerLazySingleton<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
  }) {
    _instance._injector.registerLazySingleton(
      builder,
      dependencyName: dependencyName,
    );
  }

  /// Method used to register dependency by factory
  static void registerFactory<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
  }) {
    _instance._injector.registerFactory(
      builder,
      dependencyName: dependencyName,
    );
  }

  /// Method used to register singleton dependency
  static void registerSingleton<T extends Object>(
    T value, {
    String? dependencyName,
  }) {
    _instance._injector.registerSingleton(
      value,
      dependencyName: dependencyName,
    );
  }

  static void registerSingletonAsync<T extends Object>(
    CDependencyInjectorAsyncBuilder<T> builder, {
    String? dependencyName,
  }) {
    _instance._injector.registerSingletonAsync(
      builder,
      dependencyName: dependencyName,
    );
  }

  static void registerFactoryAsync<T extends Object>(
    CDependencyInjectorAsyncBuilder<T> builder, {
    String? dependencyName,
  }) {
    _instance._injector.registerFactoryAsync(
      builder,
      dependencyName: dependencyName,
    );
  }

  /// Use to reset injector
  static void resetInjector() => _instance._injector.reset();

  /// Use to get injector
  CInjector get injector => _instance._injector;

  /// Use to register your on Injector
  set injector(CInjector injector) => _instance._injector = injector;

  /// Use to get Cube registered in de Widget tree.
  static C? of<C extends Cube>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CubeProvider<C>>()?.cube;
  }
}

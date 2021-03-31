library cube;

import 'package:flutter/widgets.dart';

import 'src/cube.dart';
import 'src/injector/get_it_injector.dart';
import 'src/injector/injector.dart';
import 'src/localization/strings_location.dart';
import 'src/util/cube_provider.dart';

export 'package:cubes/src/cube.dart';
export 'package:cubes/src/feedback_manager/feedback_manager.dart';
export 'package:cubes/src/injector/injector.dart';
export 'package:cubes/src/localization/cubes_localization_delegate.dart';
export 'package:cubes/src/localization/strings_location.dart';
export 'package:cubes/src/observable/observable_list.dart';
export 'package:cubes/src/observable/observable_value.dart';
export 'package:cubes/src/util/cube_provider.dart';
export 'package:cubes/src/util/extensions/ext.dart';
export 'package:cubes/src/util/functions.dart';
export 'package:cubes/src/util/state_mixin.dart';
export 'package:cubes/src/widgets/animated_list_cube.dart';
export 'package:cubes/src/widgets/cube_builder.dart';
export 'package:cubes/src/widgets/cube_widget.dart';
export 'package:cubes/src/widgets/text_form_field.dart';

/// Core of the package where you will have useful functions and settings
class Cubes {
  /// instance of the Cubes
  static final Cubes _instance = Cubes._internal();
  final CGetterStringLocation _stringLocation = CStringsLocation();
  CInjector _injector = GetItInjector();

  Cubes._internal();

  /// Factory to get instance of the Cubes
  factory Cubes() {
    return _instance;
  }

  /// Use to get dependency registered
  static T getDependency<T extends Object>({String? dependencyName}) {
    return _instance._injector.getDependency<T>(dependencyName: dependencyName);
  }

  /// Use to register dependency
  static void registerDependency<T extends Object>(
    CDependencyInjectorBuilder<T> builder, {
    String? dependencyName,
    bool isSingleton = false,
  }) {
    _instance._injector.registerDependency<T>(
      builder,
      dependencyName: dependencyName,
      isSingleton: isSingleton,
    );
  }

  /// Use to reset injector
  static void resetInjector() => _instance._injector.reset();

  /// Use to get injector
  CInjector get injector => _instance._injector;

  /// Use to register your on Injector
  set injector(CInjector injector) => _instance._injector = injector;

  /// Use to get StringLocation
  static CGetterStringLocation stringLocation() => _instance._stringLocation;

  /// Use to get String in StringLocation
  static String getString(String key, {Map<String, String>? params}) {
    return _instance._stringLocation.getString(key, params: params);
  }

  /// Use to get Cube registered in de Widget tree.
  static C? of<C extends Cube>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CubeProvider<C>>()?.cube;
  }
}

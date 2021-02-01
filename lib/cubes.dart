library cube;

import 'package:cubes/src/cube.dart';
import 'package:cubes/src/injector/getit_injector.dart';
import 'package:cubes/src/injector/injector.dart';
import 'package:cubes/src/localization/strings_location.dart';
import 'package:cubes/src/util/cube_provider.dart';
import 'package:flutter/widgets.dart';

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

class Cubes {
  static final Cubes instance = Cubes._internal();
  CInjector _injector = GetItInjector();
  CGetterStringLocation _stringLocation = CStringsLocation.instance;

  Cubes._internal();

  /// Use to register your on Injector
  static setCustomInjector(CInjector injector) => instance._injector = injector;

  /// Use to get dependency registered
  static T getDependency<T>({String dependencyName}) {
    return instance._injector.getDependency<T>(dependencyName: dependencyName);
  }

  /// Use to register dependency
  static void registerDependency<T>(
    DependencyInjectorBuilder<T> builder, {
    String dependencyName,
    bool isSingleton = false,
  }) {
    instance._injector.registerDependency<T>(
      builder,
      dependencyName: dependencyName,
      isSingleton: isSingleton,
    );
  }

  /// Use to reset injector
  static void resetInjector() => instance._injector.reset();

  /// Use to get injector
  static CInjector injector() => instance._injector;

  /// Use to get StringLocation
  static CGetterStringLocation stringLocation() => instance._stringLocation;

  /// Use to get String in StringLocation
  static String getString(String key, [Map<String, String> params]) {
    return instance._stringLocation.getString(key, params: params);
  }

  /// Use to get Cube registered in de Widget tree.
  static C of<C extends Cube>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CubeProvider<C>>()?.cube;
  }
}

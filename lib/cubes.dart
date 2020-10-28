library cube;

import 'package:cubes/src/injector/getit_injector.dart';
import 'package:cubes/src/injector/injector.dart';
import 'package:cubes/src/localization/strings_location.dart';

export 'package:cubes/src/cube.dart';
export 'package:cubes/src/cube_builder.dart';
export 'package:cubes/src/injector/injector.dart';
export 'package:cubes/src/localization/cubes_localization_delegate.dart';
export 'package:cubes/src/localization/strings_location.dart';
export 'package:cubes/src/observable/observable_list.dart';
export 'package:cubes/src/observable/observable_value.dart';
export 'package:cubes/src/util/extensions/ext.dart';
export 'package:cubes/src/widgets/animated_list_cube.dart';
export 'package:cubes/src/widgets/cube_widget.dart';
export 'package:cubes/src/widgets/cube_widget_animation.dart';

class Cubes {
  static final Cubes instance = Cubes._internal();
  static Injector _injector = GetItInjector();

  Cubes._internal();

  void customInjector(Injector injector) => _injector = injector;

  static T getDependency<T>({String dependencyName}) {
    return _injector.getDependency<T>(dependencyName: dependencyName);
  }

  static void registerDependency<T>(
    DependencyInjectorBuilder<T> builder, {
    String dependencyName,
    bool isSingleton = false,
  }) {
    _injector.registerDependency<T>(
      builder,
      dependencyName: dependencyName,
      isSingleton: isSingleton,
    );
  }

  static String getString(String key, [Map<String, String> params]) {
    return StringsLocation.instance.getString(key, params: params);
  }
}

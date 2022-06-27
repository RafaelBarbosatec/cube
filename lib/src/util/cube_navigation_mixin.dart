import 'package:cubes/src/actions/navigation_cube_action.dart';
import 'package:cubes/src/cube.dart';
import 'package:flutter/widgets.dart';

///
/// Created by
///
/// ─▄▀─▄▀
/// ──▀──▀
/// █▀▀▀▀▀█▄
/// █░░░░░█─█
/// ▀▄▄▄▄▄▀▀
///
/// Rafaelbarbosatec
/// on 14/02/22

mixin CubeNavigation on Cube {
  void navToNamed(
    String routeName, {
    Object? arguments,
    ValueChanged<Object?>? onResult,
  }) {
    this.sendAction(
      NavigationCubeAction.pushNamed(
        routeName: routeName,
        arguments: arguments,
        onResult: onResult,
      ),
    );
  }

  void navToNamedAndRemoveUntil(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
    ValueChanged<Object?>? onResult,
  }) {
    this.sendAction(
      NavigationCubeAction.pushNamedAndRemoveUntil(
        routeName: routeName,
        arguments: arguments,
        predicate: predicate,
        onResult: onResult,
      ),
    );
  }

  void navToNamedReplacement(
    String routeName, {
    Object? arguments,
    ValueChanged<Object?>? onResult,
  }) {
    this.sendAction(
      NavigationCubeAction.pushReplacementNamed(
        routeName: routeName,
        arguments: arguments,
        onResult: onResult,
      ),
    );
  }

  void navPop<T>([T? result]) {
    this.sendAction(
      NavigationCubeAction.pop(result: result),
    );
  }
}

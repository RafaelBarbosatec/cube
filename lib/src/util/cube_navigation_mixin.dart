import 'package:cubes/src/actions/cube_action.dart';
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

  void navTo(
    WidgetBuilder builder, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
    ValueChanged<Object?>? onResult,
  }) {
    this.sendAction(
      NavigationCubeAction.push(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
        onResult: onResult,
      ),
    );
  }

  void navToReplacement(
    WidgetBuilder builder, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
    ValueChanged<Object?>? onResult,
  }) {
    this.sendAction(
      NavigationCubeAction.pushReplacement(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
        onResult: onResult,
      ),
    );
  }

  void navToAndRemoveUntil(
    WidgetBuilder builder,
    RoutePredicate predicate, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
    ValueChanged<Object?>? onResult,
  }) {
    this.sendAction(
      NavigationCubeAction.pushAndRemoveUntil(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
        predicate: predicate,
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

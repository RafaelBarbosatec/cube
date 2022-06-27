import 'package:cubes/src/actions/cube_action.dart';
import 'package:cubes/src/util/extensions/ext.dart';
import 'package:flutter/material.dart';

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

enum NavigationType {
  pushNamed,
  pushNamedAndRemoveUntil,
  pushReplacementNamed,
  pop,
}

class NavigationCubeAction extends CubeAction {
  final String? routeName;
  final Object? arguments;
  final RouteSettings? settings;
  final bool fullscreenDialog;
  final RoutePredicate? predicate;
  final NavigationType type;
  final Object? result;
  final ValueChanged<Object?>? onResult;

  NavigationCubeAction({
    this.type = NavigationType.pushNamed,
    this.routeName,
    this.arguments,
    this.onResult,
    this.settings,
    this.fullscreenDialog = false,
    this.predicate,
    this.result,
  });

  NavigationCubeAction.pop({
    this.result,
  })  : type = NavigationType.pop,
        routeName = null,
        predicate = null,
        settings = null,
        onResult = null,
        fullscreenDialog = false,
        arguments = null;

  NavigationCubeAction.pushNamed({
    required this.routeName,
    this.arguments,
    this.onResult,
  })  : type = NavigationType.pushNamed,
        predicate = null,
        settings = null,
        fullscreenDialog = false,
        result = null;

  NavigationCubeAction.pushNamedAndRemoveUntil({
    required this.routeName,
    required this.predicate,
    this.arguments,
    this.onResult,
  })  : type = NavigationType.pushNamedAndRemoveUntil,
        settings = null,
        fullscreenDialog = false,
        result = null;

  NavigationCubeAction.pushReplacementNamed({
    required this.routeName,
    this.arguments,
    this.onResult,
  })  : type = NavigationType.pushReplacementNamed,
        settings = null,
        predicate = null,
        fullscreenDialog = false,
        result = null;

  @override
  void onExecute(BuildContext context) {
    switch (type) {
      case NavigationType.pushNamed:
        context
            .goToNamed(routeName!, arguments: arguments)
            .then((r) => onResult?.call(r));
        break;
      case NavigationType.pushNamedAndRemoveUntil:
        context
            .goToNamedAndRemoveUntil(
              routeName!,
              predicate!,
              arguments: arguments,
            )
            .then((r) => onResult?.call(r));
        break;
      case NavigationType.pushReplacementNamed:
        context
            .goToNamedReplacement(routeName!, arguments: arguments)
            .then((r) => onResult?.call(r));
        break;
      case NavigationType.pop:
        context.pop(result);
        break;
    }
  }
}

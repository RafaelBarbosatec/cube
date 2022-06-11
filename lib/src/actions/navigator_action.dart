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
  push,
  pushReplacement,
  pushAndRemoveUntil,
  pop,
}

class NavigationAction extends CubeAction {
  final String? routeName;
  final WidgetBuilder? builder;
  final Object? arguments;
  final RouteSettings? settings;
  final bool fullscreenDialog;
  final RoutePredicate? predicate;
  final NavigationType type;
  final Object? result;
  final ValueChanged<Object?>? onResult;

  NavigationAction({
    this.type = NavigationType.push,
    this.routeName,
    this.builder,
    this.arguments,
    this.onResult,
    this.settings,
    this.fullscreenDialog = false,
    this.predicate,
    this.result,
  });

  NavigationAction.push({
    required this.builder,
    this.settings,
    this.onResult,
    this.fullscreenDialog = false,
  })  : type = NavigationType.push,
        routeName = null,
        arguments = null,
        result = null,
        predicate = null;

  NavigationAction.pushReplacement({
    required this.builder,
    this.settings,
    this.onResult,
    this.fullscreenDialog = false,
  })  : type = NavigationType.pushReplacement,
        routeName = null,
        arguments = null,
        result = null,
        predicate = null;

  NavigationAction.pushAndRemoveUntil({
    required this.builder,
    required this.predicate,
    this.settings,
    this.onResult,
    this.fullscreenDialog = false,
  })  : type = NavigationType.pushAndRemoveUntil,
        routeName = null,
        result = null,
        arguments = null;

  NavigationAction.pop({
    this.result,
  })  : type = NavigationType.pop,
        routeName = null,
        predicate = null,
        settings = null,
        onResult = null,
        fullscreenDialog = false,
        builder = null,
        arguments = null;

  NavigationAction.pushNamed({
    required this.routeName,
    this.arguments,
    this.onResult,
  })  : type = NavigationType.pushNamed,
        predicate = null,
        settings = null,
        fullscreenDialog = false,
        builder = null,
        result = null;

  NavigationAction.pushNamedAndRemoveUntil({
    required this.routeName,
    required this.predicate,
    this.arguments,
    this.onResult,
  })  : type = NavigationType.pushNamedAndRemoveUntil,
        settings = null,
        fullscreenDialog = false,
        builder = null,
        result = null;

  NavigationAction.pushReplacementNamed({
    required this.routeName,
    this.arguments,
    this.onResult,
  })  : type = NavigationType.pushReplacementNamed,
        settings = null,
        predicate = null,
        fullscreenDialog = false,
        builder = null,
        result = null;

  void handle(BuildContext context) {
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
      case NavigationType.push:
        context
            .goTo(
              builder!,
              settings: settings,
              fullscreenDialog: fullscreenDialog,
            )
            .then((r) => onResult?.call(r));
        break;
      case NavigationType.pushReplacement:
        context
            .goToReplacement(
              builder!,
              settings: settings,
              fullscreenDialog: fullscreenDialog,
            )
            .then((r) => onResult?.call(r));
        break;
      case NavigationType.pushAndRemoveUntil:
        context
            .goToAndRemoveUntil(
              builder!,
              predicate!,
              settings: settings,
              fullscreenDialog: fullscreenDialog,
            )
            .then((r) => onResult?.call(r));
        break;
      case NavigationType.pop:
        context.pop(result);
        break;
    }
  }
}

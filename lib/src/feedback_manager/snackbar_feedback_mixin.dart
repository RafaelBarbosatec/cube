import 'package:cubes/src/feedback_manager/feedback_manager.dart';
import 'package:cubes/src/observable/observable_value.dart';
import 'package:flutter/material.dart';

typedef SnackBar SnackBarByDataBuilder<T>(T data, BuildContext context);

/// Class responsible for configuring the SnackBars
class CSnackBarController<T> {
  final SnackBarAction action;
  final ObservableValue<CFeedBackControl<T>> observable;
  final SnackBarByDataBuilder<T> builder;
  final Duration duration;
  final ShapeBorder shape;
  final double elevation;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final SnackBarBehavior behavior;

  SnackBar doBuild(T data, BuildContext context) {
    return builder(data, context);
  }

  CSnackBarController({
    @required this.observable,
    @required this.builder,
    this.action,
    this.duration = const Duration(seconds: 4),
    this.shape,
    this.elevation,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.behavior,
  });
}

/// Mixin responsible for adding listeners to ObservableValue and controlling the display of SnackBars
mixin SnackBarFeedBackMixin<T extends StatefulWidget> on State<T> {
  List<CSnackBarController> snackBarControllers;
  Map<CSnackBarController, bool> _mapSnackBarIsShowing = Map();

  /// Configure listeners of the snackBarControllers.
  void confSnackBarFeedBack(List<CSnackBarController> controllers) {
    this.snackBarControllers = controllers;
    this.snackBarControllers?.forEach((element) {
      _mapSnackBarIsShowing[element] = false;
      element.observable.addListener(() => _listenerDialogController(element));
    });
  }

  @override
  void dispose() {
    snackBarControllers?.forEach((element) => element.observable.dispose());
    super.dispose();
  }

  /// Listener that controls the display of the snackBar.
  void _listenerDialogController(CSnackBarController element) {
    if (!mounted) return;
    if (element.observable.value.show && !_mapSnackBarIsShowing[element]) {
      _showSnackBar(element);
    } else if (!element.observable.value.show && _mapSnackBarIsShowing[element]) {
      _mapSnackBarIsShowing[element] = false;
      Scaffold.of(context)?.hideCurrentSnackBar();
    }
  }

  /// Displays SnackBar with the added settings.
  void _showSnackBar(CSnackBarController element) async {
    _mapSnackBarIsShowing[element] = true;
    Scaffold.of(context)?.showSnackBar(element.doBuild(element.observable.value.data, context));
    await Future.delayed(element.duration);
    _mapSnackBarIsShowing[element] = false;
    // ignore: invalid_use_of_protected_member
    element.observable.setInitialValue(element.observable.value.copyWith(show: false));
  }
}

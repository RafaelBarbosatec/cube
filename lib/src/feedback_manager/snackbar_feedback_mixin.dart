import 'package:flutter/material.dart';

import '../observable/observable_value.dart';
import 'feedback_manager.dart';

typedef SnackBarByDataBuilder<T> = SnackBar Function(
    T data, BuildContext context);

/// Class responsible for configuring the SnackBars
class CSnackBarController<T> {
  final ObservableValue<CFeedBackControl<T>> observable;
  final SnackBarByDataBuilder<T> builder;

  /// Method used to get SnackBar with data type
  SnackBar doBuild(T data, BuildContext context) {
    return builder(data, context);
  }

  /// Constructor of the CSnackBarController
  CSnackBarController({
    @required this.observable,
    @required this.builder,
  });
}

/// Mixin responsible for adding listeners to ObservableValue and controlling the display of SnackBars
mixin SnackBarFeedBackMixin<T extends StatefulWidget> on State<T> {
  List<CSnackBarController> snackBarControllers;
  final Map<CSnackBarController, bool> _mapSnackBarIsShowing = {};

  /// Configure listeners of the snackBarControllers.
  void confSnackBarFeedBack(List<CSnackBarController> controllers) {
    snackBarControllers = controllers;
    snackBarControllers?.forEach(_registerSnackBar);
  }

  @override
  void dispose() {
    snackBarControllers?.forEach(_disposeSnackBar);
    super.dispose();
  }

  /// Listener that controls the display of the snackBar.
  void _listenerDialogController(CSnackBarController element) {
    if (!mounted) return;
    if (element.observable.value.show && !_mapSnackBarIsShowing[element]) {
      _showSnackBar(element);
    } else if (!element.observable.value.show &&
        _mapSnackBarIsShowing[element]) {
      _mapSnackBarIsShowing[element] = false;
      Scaffold.of(context)?.hideCurrentSnackBar();
    }
  }

  /// Displays SnackBar with the added settings.
  void _showSnackBar(CSnackBarController element) async {
    _mapSnackBarIsShowing[element] = true;

    final snackBar = element.doBuild(element.observable.value.data, context);
    Scaffold.of(context)?.showSnackBar(snackBar);

    await Future.delayed(snackBar.duration);

    _mapSnackBarIsShowing[element] = false;
    element.observable.setValueWithoutNotify =
        element.observable.value.copyWith(show: false);
  }

  void _registerSnackBar(CSnackBarController element) {
    _mapSnackBarIsShowing[element] = false;
    element.observable.addListener(() => _listenerDialogController(element));
  }

  void _disposeSnackBar(CSnackBarController element) {
    element.observable.dispose();
  }
}

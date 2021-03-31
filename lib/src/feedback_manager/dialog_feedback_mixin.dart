import 'package:flutter/material.dart';

import '../observable/observable_value.dart';
import 'feedback_manager.dart';

/// Class responsible for configuring the dialogs
class CDialogController<T> {
  final bool dismissible;
  final Color? barrierColor;
  final bool useSafeArea;
  final bool useRootNavigator;
  final RouteSettings? routeSettings;
  final ObservableValue<CFeedBackControl<T>> observable;
  final WidgetByDataBuilder<T> builder;

  Widget doBuild(T data, BuildContext context) {
    return builder(data, context);
  }

  CDialogController({
    required this.observable,
    required this.builder,
    this.dismissible = true,
    this.barrierColor = Colors.black54,
    this.useSafeArea = true,
    this.useRootNavigator = true,
    this.routeSettings,
  });
}

/// Mixin responsible for adding listeners to ObservableValue and controlling
/// the display of dialogs
mixin DialogFeedBackMixin<T extends StatefulWidget> on State<T> {
  static const ANIMATION_DURATION = 150;
  final Map<CDialogController, bool> _mapDialogIsShowing = {};
  final Map<CDialogController, VoidCallback> _mapDialogListeners = {};
  List<CDialogController>? dialogControllers;

  /// Configure listeners of the dialogControllers.
  void confDialogFeedBack(List<CDialogController>? controllers) {
    dialogControllers = controllers;
    dialogControllers?.forEach(_registerDialog);
  }

  @override
  void dispose() {
    dialogControllers?.forEach(_disposeDialog);
    super.dispose();
  }

  /// Listener that controls the display of the Dialog.
  void _listenerDialogController(CDialogController element) {
    if (!mounted) return;
    if (element.observable.value.show && !_mapDialogIsShowing[element]!) {
      _showDialog(element);
    } else if (!element.observable.value.show &&
        _mapDialogIsShowing[element]!) {
      _mapDialogIsShowing[element] = false;
      Navigator.pop(context);
    }
  }

  /// Displays Dialog with the added settings.
  void _showDialog(CDialogController element) async {
    await Future.delayed(Duration(milliseconds: ANIMATION_DURATION));
    _mapDialogIsShowing[element] = true;
    await showDialog(
        context: context,
        barrierDismissible: element.dismissible,
        barrierColor: element.barrierColor,
        useSafeArea: element.useSafeArea,
        useRootNavigator: element.useRootNavigator,
        routeSettings: element.routeSettings,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(element.dismissible),
            child: element.doBuild(element.observable.value.data, context),
          );
        });
    _mapDialogIsShowing[element] = false;
    element.observable.setValueWithoutNotify =
        element.observable.value.copyWith(show: false);
  }

  void _registerDialog(CDialogController element) {
    _mapDialogIsShowing[element] = false;
    _mapDialogListeners[element] = () => _listenerDialogController(element);
    element.observable.addListener(_mapDialogListeners[element]!);
  }

  void _disposeDialog(CDialogController element) {
    element.observable.removeListener(_mapDialogListeners[element]!);
  }
}

import 'package:cubes/src/feedback_manager/feedback_manager.dart';
import 'package:cubes/src/observable/observable_value.dart';
import 'package:flutter/material.dart';

class DialogController<T> {
  final bool dismissible;
  final Color barrierColor;
  final bool useSafeArea;
  final bool useRootNavigator;
  final RouteSettings routeSettings;
  final ObservableValue<FeedBackControl<T>> observable;
  final WidgetByDataBuilder<T> builder;

  Widget doBuild(T data, BuildContext context) {
    return builder(data, context);
  }

  DialogController({
    @required this.observable,
    @required this.builder,
    this.dismissible = true,
    this.barrierColor,
    this.useSafeArea = true,
    this.useRootNavigator = true,
    this.routeSettings,
  });
}

mixin DialogFeedBackMixin<T extends StatefulWidget> on State<T> {
  static const ANIMATION_DURATION = 150;
  Map<DialogController, bool> _mapDialogIsShowing = Map();
  Map<DialogController, Function> _mapDialogListeners = Map();
  List<DialogController> dialogControllers;

  void confDialogFeedBack(List<DialogController> controllers) {
    this.dialogControllers = controllers;
    this.dialogControllers?.forEach((element) {
      _mapDialogIsShowing[element] = false;
      _mapDialogListeners[element] = () => _listenerDialogController(element);
      element.observable.addListener(_mapDialogListeners[element]);
    });
  }

  @override
  void dispose() {
    dialogControllers?.forEach((element) => element.observable.removeListener(_mapDialogListeners[element]));
    super.dispose();
  }

  void _listenerDialogController(DialogController element) {
    if (!mounted) return;
    if (element.observable.value.show && !_mapDialogIsShowing[element]) {
      _showDialog(element);
    } else if (!element.observable.value.show && _mapDialogIsShowing[element]) {
      _mapDialogIsShowing[element] = false;
      Navigator.pop(context);
    }
  }

  void _showDialog(DialogController element) async {
    await Future.delayed(Duration(milliseconds: ANIMATION_DURATION));
    _mapDialogIsShowing[element] = true;
    await showDialog(
      context: context,
      barrierDismissible: element.dismissible,
      barrierColor: element.barrierColor,
      useSafeArea: element.useSafeArea,
      useRootNavigator: element.useRootNavigator,
      routeSettings: element.routeSettings,
      child: WillPopScope(
        onWillPop: () => Future.value(element.dismissible),
        child: element.doBuild(element.observable.value.data, context),
      ),
    );
    _mapDialogIsShowing[element] = false;
    // ignore: invalid_use_of_protected_member
    element.observable.setInitialValue(element.observable.value.copyWith(show: false));
  }
}

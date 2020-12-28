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
  List<DialogController> dialogControllers;

  void confDialogFeedBack(List<DialogController> controllers) {
    this.dialogControllers = controllers;
    this.dialogControllers?.forEach((element) {
      _mapDialogIsShowing[element] = false;
      element.observable.addListener(() => _listenerDialogController(element));
    });
  }

  @override
  void dispose() {
    dialogControllers?.forEach((element) => element.observable.dispose());
    super.dispose();
  }

  void _listenerDialogController(DialogController element) {
    if (element.observable.value.show && !_mapDialogIsShowing[element]) {
      if (mounted) {
        _showDialog(element);
      }
    } else if (_mapDialogIsShowing[element]) {
      if (mounted) {
        _mapDialogIsShowing[element] = false;
        Navigator.pop(context);
      }
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
  }
}

import 'package:cubes/src/feedback_manager/feedback_manager.dart';
import 'package:cubes/src/observable/observable_value.dart';
import 'package:flutter/material.dart';

class BottomSheetController {
  final ObservableValue<FeedBackControl> observable;
  final WidgetByDataBuilder builder;
  final bool dismissible;
  final Color barrierColor;
  final Color backgroundColor;
  final bool useSafeArea;
  final bool useRootNavigator;
  final RouteSettings routeSettings;
  final double elevation;
  final bool enableDrag;
  final bool isScrollControlled;
  final ShapeBorder shape;
  final Clip clipBehavior;

  BottomSheetController({
    @required this.observable,
    @required this.builder,
    this.dismissible = true,
    this.barrierColor,
    this.useSafeArea = true,
    this.useRootNavigator = true,
    this.routeSettings,
    this.backgroundColor,
    this.elevation,
    this.enableDrag = true,
    this.isScrollControlled = false,
    this.shape,
    this.clipBehavior,
  });
}

mixin BottomSheetFeedBackMixin<T extends StatefulWidget> on State<T> {
  static const ANIMATION_DURATION = 300;
  Map<BottomSheetController, bool> _mapDialogIsShowing = Map();
  List<BottomSheetController> bottomSheetControllers;

  void confBottomSheetFeedBack(List<BottomSheetController> controllers) {
    this.bottomSheetControllers = controllers;
    this.bottomSheetControllers?.forEach((element) {
      _mapDialogIsShowing[element] = false;
      element.observable.addListener(() => _listenerDialogController(element));
    });
  }

  @override
  void dispose() {
    bottomSheetControllers?.forEach((element) => element.observable.dispose());
    super.dispose();
  }

  void _listenerDialogController(BottomSheetController element) {
    if (element.observable.value.show && !_mapDialogIsShowing[element]) {
      if (mounted) {
        _showBottomSheet(element);
      }
    } else if (_mapDialogIsShowing[element]) {
      if (mounted) {
        _mapDialogIsShowing[element] = false;
        Navigator.pop(context);
      }
    }
  }

  void _showBottomSheet(BottomSheetController element) async {
    await Future.delayed(Duration(milliseconds: ANIMATION_DURATION));
    _mapDialogIsShowing[element] = true;
    await showModalBottomSheet(
      context: context,
      isDismissible: element.dismissible,
      barrierColor: element.barrierColor,
      useRootNavigator: element.useRootNavigator,
      routeSettings: element.routeSettings,
      backgroundColor: element.backgroundColor,
      elevation: element.elevation,
      enableDrag: element.enableDrag,
      isScrollControlled: element.isScrollControlled,
      shape: element.shape,
      clipBehavior: element.clipBehavior,
      builder: (context) => element.builder(element.observable.value.data, context),
    );
    _mapDialogIsShowing[element] = false;
  }
}

import 'package:flutter/material.dart';

import '../observable/observable_value.dart';
import 'feedback_manager.dart';

/// Class responsible for configuring the BottomSheets
class CBottomSheetController<T> {
  final ObservableValue<CFeedBackControl<T>> observable;
  final WidgetByDataBuilder<T> builder;
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

  Widget doBuild(T data, BuildContext context) {
    return builder(data, context);
  }

  CBottomSheetController({
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

/// Mixin responsible for adding listeners to ObservableValue and controlling the display of BottomSheets
mixin BottomSheetFeedBackMixin<T extends StatefulWidget> on State<T> {
  static const ANIMATION_DURATION = 150;
  final Map<CBottomSheetController, bool> _mapBottomSheetIsShowing = {};
  final Map<CBottomSheetController, Function> _mapBottomSheetListeners = {};
  List<CBottomSheetController> bottomSheetControllers;

  /// Configure listeners of the bottomSheetControllers.
  void confBottomSheetFeedBack(List<CBottomSheetController> controllers) {
    bottomSheetControllers = controllers;
    bottomSheetControllers?.forEach(_registerBottomSheet);
  }

  @override
  void dispose() {
    bottomSheetControllers?.forEach(_disposeBottomSheet);
    super.dispose();
  }

  /// Listener that controls the display of the Bottom Sheet.
  void _listenerDialogController(CBottomSheetController element) {
    if (!mounted) return;
    if (element.observable.value.show && !_mapBottomSheetIsShowing[element]) {
      _showBottomSheet(element);
    } else if (!element.observable.value.show && _mapBottomSheetIsShowing[element]) {
      _mapBottomSheetIsShowing[element] = false;
      Navigator.pop(context);
    }
  }

  /// Displays Bottom Sheet with the added settings.
  void _showBottomSheet(CBottomSheetController element) async {
    await Future.delayed(Duration(milliseconds: ANIMATION_DURATION));
    _mapBottomSheetIsShowing[element] = true;
    await showModalBottomSheet(
      context: context,
      isDismissible: element.dismissible,
      barrierColor: element.barrierColor,
      useRootNavigator: element.useRootNavigator,
      routeSettings: element.routeSettings,
      backgroundColor: element.backgroundColor,
      elevation: element.elevation,
      enableDrag: element.dismissible ? element.enableDrag : false,
      isScrollControlled: element.isScrollControlled,
      shape: element.shape,
      clipBehavior: element.clipBehavior,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(element.dismissible),
        child: element.doBuild(element.observable.value.data, context),
      ),
    );
    _mapBottomSheetIsShowing[element] = false;
    element.observable.setValueWithoutNotify = element.observable.value.copyWith(show: false);
  }

  void _registerBottomSheet(CBottomSheetController element) {
    _mapBottomSheetIsShowing[element] = false;
    _mapBottomSheetListeners[element] = () => _listenerDialogController(element);
    element.observable.addListener(_mapBottomSheetListeners[element]);
  }

  void _disposeBottomSheet(CBottomSheetController element) {
    element.observable.removeListener(_mapBottomSheetListeners[element]);
  }
}

import 'package:cubes/src/feedback_manager/feedback_manager.dart';
import 'package:cubes/src/observable/observable_value.dart';
import 'package:flutter/material.dart';

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
  Map<CBottomSheetController, bool> _mapBottomSheetIsShowing = Map();
  Map<CBottomSheetController, Function> _mapBottomSheetListeners = Map();
  List<CBottomSheetController> bottomSheetControllers;

  void confBottomSheetFeedBack(List<CBottomSheetController> controllers) {
    this.bottomSheetControllers = controllers;
    this.bottomSheetControllers?.forEach((element) {
      _mapBottomSheetIsShowing[element] = false;
      _mapBottomSheetListeners[element] = () => _listenerDialogController(element);
      element.observable.addListener(_mapBottomSheetListeners[element]);
    });
  }

  @override
  void dispose() {
    bottomSheetControllers?.forEach((element) => element.observable.removeListener(_mapBottomSheetListeners[element]));
    super.dispose();
  }

  void _listenerDialogController(CBottomSheetController element) {
    if (!mounted) return;
    if (element.observable.value.show && !_mapBottomSheetIsShowing[element]) {
      _showBottomSheet(element);
    } else if (!element.observable.value.show && _mapBottomSheetIsShowing[element]) {
      _mapBottomSheetIsShowing[element] = false;
      Navigator.pop(context);
    }
  }

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
    // ignore: invalid_use_of_protected_member
    element.observable.setInitialValue(element.observable.value.copyWith(show: false));
  }
}

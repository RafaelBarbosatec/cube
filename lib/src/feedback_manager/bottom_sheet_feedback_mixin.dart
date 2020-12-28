import 'package:cubes/src/feedback_manager/feedback_manager.dart';
import 'package:cubes/src/observable/observable_value.dart';
import 'package:flutter/material.dart';

class BottomSheetController<T> {
  final ObservableValue<FeedBackControl<T>> observable;
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
  static const ANIMATION_DURATION = 150;
  Map<BottomSheetController, bool> _mapBottomSheetIsShowing = Map();
  Map<BottomSheetController, Function> _mapBottomSheetListeners = Map();
  List<BottomSheetController> bottomSheetControllers;

  void confBottomSheetFeedBack(List<BottomSheetController> controllers) {
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

  void _listenerDialogController(BottomSheetController element) {
    if (element.observable.value.show && !_mapBottomSheetIsShowing[element]) {
      if (mounted) {
        _showBottomSheet(element);
      }
    } else if (_mapBottomSheetIsShowing[element]) {
      if (mounted) {
        _mapBottomSheetIsShowing[element] = false;
        Navigator.pop(context);
      }
    }
  }

  void _showBottomSheet(BottomSheetController element) async {
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
  }
}

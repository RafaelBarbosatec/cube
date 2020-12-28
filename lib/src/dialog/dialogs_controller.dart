import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

typedef Widget DialogBuilder<T>(T data, BuildContext context);

class DialogControl<T> {
  final bool show;
  final T data;

  DialogControl({this.show = false, this.data});

  DialogControl<T> copyWith({bool show, T data}) {
    return DialogControl(
      show: show ?? this.show,
      data: data ?? this.data,
    );
  }
}

class DialogController {
  final bool dismissible;
  final Color barrierColor;
  final bool useSafeArea;
  final bool useRootNavigator;
  final RouteSettings routeSettings;
  final ObservableValue<DialogControl> observable;
  final DialogBuilder builder;

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

class DialogsManager extends StatefulWidget {
  final List<DialogController> controllers;
  final Widget child;

  const DialogsManager({Key key, this.controllers, @required this.child}) : super(key: key);

  @override
  _DialogsManagerState createState() => _DialogsManagerState();
}

class _DialogsManagerState extends State<DialogsManager> {
  static const ANIMATION_DURATION = 300;
  Map<DialogController, bool> _mapDialogIsShowing = Map();

  @override
  void initState() {
    widget.controllers.forEach((element) {
      _mapDialogIsShowing[element] = false;
      element.observable.addListener(() => _listenerDialogController(element));
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controllers.forEach((element) => element.observable.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

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
        child: element.builder(element.observable.value.data, context),
      ),
    );
    _mapDialogIsShowing[element] = false;
  }
}

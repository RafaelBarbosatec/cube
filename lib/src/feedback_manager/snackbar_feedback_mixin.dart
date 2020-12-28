import 'package:cubes/src/feedback_manager/feedback_manager.dart';
import 'package:cubes/src/observable/observable_value.dart';
import 'package:flutter/material.dart';

typedef SnackBar SnackBarByDataBuilder<T>(T data, BuildContext context);

class SnackBarController<T> {
  final SnackBarAction action;
  final ObservableValue<FeedBackControl<T>> observable;
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

  SnackBarController({
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

mixin SnackBarFeedBackMixin<T extends StatefulWidget> on State<T> {
  List<SnackBarController> snackBarControllers;

  void confSnackBarFeedBack(List<SnackBarController> controllers) {
    this.snackBarControllers = controllers;
    this.snackBarControllers?.forEach((element) {
      element.observable.addListener(() => _listenerDialogController(element));
    });
  }

  @override
  void dispose() {
    snackBarControllers?.forEach((element) => element.observable.dispose());
    super.dispose();
  }

  void _listenerDialogController(SnackBarController element) {
    if (element.observable.value.show) {
      if (mounted) {
        _showSnackBar(element);
      }
    }
  }

  void _showSnackBar(SnackBarController element) async {
    Scaffold.of(context)?.showSnackBar(element.doBuild(element.observable.value.data, context));
  }
}

import 'package:cubes/src/cube.dart';
import 'package:cubes/src/injector.dart';
import 'package:cubes/src/util/functions.dart';
import 'package:flutter/material.dart';

typedef AsyncWidgetBuilder<C extends Cube> = Widget Function(
  BuildContext context,
  C cube,
);

// ignore: must_be_immutable
class CubeBuilder<C extends Cube> extends StatefulWidget {
  CubeBuilder({
    Key key,
    @required this.builder,
    this.onSuccess,
    this.onError,
    this.initData,
    this.cube,
    this.onAction,
  }) : super(key: key) {
    _confBuilders();
  }

  final dynamic initData;
  final AsyncWidgetBuilder<C> builder;
  final FeedbackChanged<C, String> onSuccess;
  final FeedbackChanged<C, String> onError;
  final FeedbackChanged<C, dynamic> onAction;
  final C cube;
  AsyncWidgetBuilder _builderInner;
  FeedbackChanged _builderOnSuccess;
  FeedbackChanged _builderOnError;
  FeedbackChanged _builderOnAction;

  void _confBuilders() {
    _builderInner = (context, cube) => builder(context, cube);
    _builderOnSuccess = (cube, text) => onSuccess(cube, text);
    _builderOnError = (cube, text) => onError(cube, text);
    _builderOnAction = (cube, data) => onAction(cube, data);
  }

  @override
  _CubeBuilderState<C> createState() => _CubeBuilderState<C>();
}

class _CubeBuilderState<C extends Cube> extends State<CubeBuilder> {
  C cube;

  @override
  void initState() {
    if (widget.cube == null) {
      cube = getDependency();
    } else {
      cube = widget.cube;
    }
    cube.data = widget.initData;
    cube.addOnSuccessListener(_onSuccess);
    cube.addOnErrorListener(_onError);
    cube.addOnActionListener(_onAction);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => cube.ready());
  }

  @override
  void dispose() {
    cube.removeOnSuccessListener(_onSuccess);
    cube.removeOnErrorListener(_onError);
    cube.removeOnActionListener(_onAction);
    cube.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builderInner(context, cube);
  }

  void _onSuccess(C cube, String text) {
    postFrame(() {
      if (mounted) {
        widget._builderOnSuccess(cube, text);
      }
    });
  }

  void _onError(C cube, String text) {
    postFrame(() {
      if (mounted) {
        widget._builderOnError(cube, text);
      }
    });
  }

  void _onAction(C cube, dynamic data) {
    postFrame(() {
      if (mounted) {
        widget._builderOnAction(cube, data);
      }
    });
  }
}

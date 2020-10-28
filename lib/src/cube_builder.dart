import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:cubes/src/util/functions.dart';
import 'package:flutter/material.dart';

typedef AsyncCubeWidgetBuilder<C extends Cube> = Widget Function(
  BuildContext context,
  C cube,
);

typedef InitCallback<C extends Cube> = Function(C cube);

class CubeBuilder<C extends Cube> extends StatefulWidget {
  const CubeBuilder({
    Key key,
    @required this.builder,
    this.onSuccess,
    this.onError,
    this.initData,
    this.cube,
    this.onAction,
    this.initState,
    this.dispose,
  }) : super(key: key);

  final dynamic initData;
  final AsyncCubeWidgetBuilder<C> builder;
  final FeedbackChanged<C, String> onSuccess;
  final FeedbackChanged<C, String> onError;
  final FeedbackChanged<C, dynamic> onAction;
  final InitCallback<C> initState;
  final VoidCallback dispose;
  final C cube;

  @override
  _CubeBuilderState<C> createState() => _CubeBuilderState<C>();
}

class _CubeBuilderState<C extends Cube> extends State<CubeBuilder> {
  C cube;

  @override
  void initState() {
    if (widget.cube == null) {
      cube = Cubes.getDependency();
    } else {
      cube = widget.cube;
    }
    cube.data = widget.initData;
    cube.addOnSuccessListener(_onSuccess);
    cube.addOnErrorListener(_onError);
    cube.addOnActionListener(_onAction);
    super.initState();
    cubeWidget.initState?.call(cube);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cube.ready();
    });
  }

  @override
  void dispose() {
    cube.removeOnSuccessListener(_onSuccess);
    cube.removeOnErrorListener(_onError);
    cube.removeOnActionListener(_onAction);
    cube.dispose();
    cubeWidget.dispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return cubeWidget.builder(context, cube);
  }

  void _onSuccess(C cube, String text) {
    postFrame(() {
      if (mounted) {
        cubeWidget.onSuccess(cube, text);
      }
    });
  }

  void _onError(C cube, String text) {
    postFrame(() {
      if (mounted) {
        cubeWidget.onError(cube, text);
      }
    });
  }

  void _onAction(C cube, dynamic data) {
    postFrame(() {
      if (mounted) {
        cubeWidget.onAction(cube, data);
      }
    });
  }

  CubeBuilder<C> get cubeWidget => (widget as CubeBuilder<C>);
}

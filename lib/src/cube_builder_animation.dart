import 'package:cubes/src/cube.dart';
import 'package:cubes/src/cube_builder.dart';
import 'package:cubes/src/injector.dart';
import 'package:cubes/src/util/functions.dart';
import 'package:flutter/material.dart';

typedef InitStateWithTickerCallback<C extends Cube> = Function(
    C cube, TickerProvider vsync);

class CubeBuilderAnimation<C extends Cube> extends StatefulWidget {
  const CubeBuilderAnimation({
    Key key,
    @required this.builder,
    this.onSuccess,
    this.onError,
    this.initData,
    this.cube,
    this.onAction,
    this.initState,
    this.initView,
    this.dispose,
  }) : super(key: key);

  final dynamic initData;
  final AsyncCubeWidgetBuilder<C> builder;
  final FeedbackChanged<C, String> onSuccess;
  final FeedbackChanged<C, String> onError;
  final FeedbackChanged<C, dynamic> onAction;
  final InitStateWithTickerCallback<C> initState;
  final InitCallback<C> initView;
  final VoidCallback dispose;
  final C cube;

  @override
  _CubeBuilderAnimationState<C> createState() =>
      _CubeBuilderAnimationState<C>();
}

class _CubeBuilderAnimationState<C extends Cube>
    extends State<CubeBuilderAnimation> with TickerProviderStateMixin {
  C cube;

  @override
  void initState() {
    if (widget.cube == null) {
      cube = getCube();
    } else {
      cube = widget.cube;
    }
    cube.data = widget.initData;
    cube.addOnSuccessListener(_onSuccess);
    cube.addOnErrorListener(_onError);
    cube.addOnActionListener(_onAction);
    super.initState();
    cubeWidget.initState?.call(cube, this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubeWidget.initView?.call(cube);
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

  CubeBuilderAnimation<C> get cubeWidget => (widget as CubeBuilderAnimation<C>);
}
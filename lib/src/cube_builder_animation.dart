import 'package:cubes/cubes.dart';
import 'package:cubes/src/action/cube_action.dart';
import 'package:cubes/src/cube.dart';
import 'package:cubes/src/cube_builder.dart';
import 'package:cubes/src/util/state_mixin.dart';
import 'package:flutter/material.dart';

typedef InitStateWithTickerCallback<C extends Cube> = Function(C cube, TickerProvider vsync);

class CubeBuilderAnimation<C extends Cube> extends StatefulWidget {
  const CubeBuilderAnimation({
    Key key,
    @required this.builder,
    this.initData,
    this.cube,
    this.onAction,
    this.initState,
    this.dispose,
  }) : super(key: key);

  final dynamic initData;
  final AsyncCubeWidgetBuilder<C> builder;
  final OnActionChanged<C, CubeAction> onAction;
  final InitStateWithTickerCallback<C> initState;
  final VoidCallback dispose;
  final C cube;

  @override
  _CubeBuilderAnimationState<C> createState() => _CubeBuilderAnimationState<C>();
}

class _CubeBuilderAnimationState<C extends Cube> extends State<CubeBuilderAnimation>
    with TickerProviderStateMixin, StateMixin {
  C cube;

  @override
  void initState() {
    if (widget.cube == null) {
      cube = Cubes.getDependency();
    } else {
      cube = widget.cube;
    }
    cube.data = widget.initData;
    cube.addOnActionListener(_onAction);
    super.initState();
    cubeWidget.initState?.call(cube, this);
    WidgetsBinding.instance.addPostFrameCallback((_) => cube.ready());
  }

  @override
  void dispose() {
    cube.removeOnActionListener(_onAction);
    cube.dispose();
    cubeWidget.dispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return cubeWidget.builder(context, cube);
  }

  void _onAction(C cube, dynamic data) {
    postFrame(() => cubeWidget.onAction(cube, data));
  }

  CubeBuilderAnimation<C> get cubeWidget => (widget as CubeBuilderAnimation<C>);
}

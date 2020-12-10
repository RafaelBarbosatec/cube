import 'package:cubes/cubes.dart';
import 'package:cubes/src/action/cube_action.dart';
import 'package:cubes/src/cube.dart';
import 'package:cubes/src/util/cube_provider.dart';
import 'package:cubes/src/util/state_mixin.dart';
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
    this.initData,
    this.cube,
    this.onAction,
    this.initState,
    this.dispose,
    this.callCubeDispose = true,
  }) : super(key: key);

  final dynamic initData;
  final AsyncCubeWidgetBuilder<C> builder;
  final OnActionChanged<C, CubeAction> onAction;
  final InitCallback<C> initState;
  final VoidCallback dispose;
  final bool callCubeDispose;
  final C cube;

  @override
  _CubeBuilderState<C> createState() => _CubeBuilderState<C>();
}

class _CubeBuilderState<C extends Cube> extends State<CubeBuilder> with StateMixin {
  C cube;

  @override
  void initState() {
    cube = widget.cube ?? Cubes.getDependency();
    cube.data = widget.initData;
    cube.addOnActionListener(_onAction);
    super.initState();
    cubeWidget.initState?.call(cube);
    if (!cube.isReady) WidgetsBinding.instance.addPostFrameCallback((_) => cube.ready());
  }

  @override
  void dispose() {
    cube.removeOnActionListener(_onAction);
    if (widget.callCubeDispose) cube.dispose();
    cubeWidget.dispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubeProvider(
      cube: cube,
      child: cubeWidget.builder(context, cube),
    );
  }

  void _onAction(C cube, dynamic data) {
    postFrame(() => cubeWidget.onAction(cube, data));
  }

  CubeBuilder<C> get cubeWidget => (widget as CubeBuilder<C>);
}

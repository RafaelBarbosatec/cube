import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:cubes/src/util/cube_provider.dart';
import 'package:cubes/src/util/state_mixin.dart';
import 'package:flutter/material.dart';

typedef AsyncCubeWidgetBuilder<C extends Cube> = Widget Function(
  BuildContext context,
  C cube,
);

typedef InitCallback<C extends Cube> = Function(C cube);
typedef CubeWidgetDispose<C extends Cube> = bool Function(C cube);

class CubeBuilder<C extends Cube> extends StatefulWidget {
  const CubeBuilder({
    Key key,
    @required this.builder,
    this.arguments,
    this.cube,
    this.onAction,
    this.initState,
    this.dispose,
  }) : super(key: key);

  final Object arguments;
  final AsyncCubeWidgetBuilder<C> builder;
  final OnActionChanged<C, CubeAction> onAction;
  final InitCallback<C> initState;
  final CubeWidgetDispose<C> dispose;
  final C cube;

  @override
  _CubeBuilderState<C> createState() => _CubeBuilderState<C>();
}

class _CubeBuilderState<C extends Cube> extends State<CubeBuilder> with StateMixin {
  C cube;

  @override
  void initState() {
    cube = widget.cube ?? Cubes.getDependency();
    cube.addOnActionListener(_onAction);
    super.initState();
    cubeWidget.initState?.call(cube);
    WidgetsBinding.instance.addPostFrameCallback(_ready);
  }

  @override
  void dispose() {
    if (cubeWidget.dispose?.call(cube) ?? true) cube.dispose();
    cube.removeOnActionListener(_onAction);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubeProvider(
      cube: cube,
      child: cubeWidget.builder(context, cube),
    );
  }

  void _onAction(C cube, CubeAction data) {
    postFrame(() => cubeWidget.onAction(cube, data));
  }

  void _ready(_) {
    Object arguments = widget.arguments ?? ModalRoute.of(context)?.settings?.arguments;
    cube.onReady(arguments);
  }

  CubeBuilder<C> get cubeWidget => (widget as CubeBuilder<C>);
}

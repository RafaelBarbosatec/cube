import 'package:flutter/material.dart';

import '../../cubes.dart';
import '../cube.dart';
import '../util/cube_provider.dart';
import '../util/state_mixin.dart';

typedef AsyncCubeWidgetBuilder<C extends Cube> = Widget Function(
  BuildContext context,
  C cube,
);

typedef InitCallback<C extends Cube> = Function(C cube);
typedef CubeWidgetDispose<C extends Cube> = bool Function(C cube);

/// Widget responsible for getting instance and providing Cube
class CubeBuilder<C extends Cube> extends StatefulWidget {
  const CubeBuilder({
    Key? key,
    required this.builder,
    this.arguments,
    this.cube,
    this.onAction,
    this.dispose,
  }) : super(key: key);

  final Object? arguments;
  final AsyncCubeWidgetBuilder<C> builder;
  final OnActionChanged<C, CubeAction>? onAction;
  final CubeWidgetDispose<C>? dispose;
  final C? cube;

  @override
  _CubeBuilderState<C> createState() => _CubeBuilderState<C>();
}

class _CubeBuilderState<C extends Cube> extends State<CubeBuilder>
    with StateMixin {
  late C cube;

  @override
  void initState() {
    cube = cubeWidget.cube ?? Cubes.getDependency();
    cube.addOnActionListener(_onAction);
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(_ready);
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
    postFrame(() => cubeWidget.onAction?.call(cube, data));
  }

  void _ready(_) {
    var arguments =
        widget.arguments ?? ModalRoute.of(context)?.settings.arguments;
    cube.onReady(arguments);
  }

  CubeBuilder<C> get cubeWidget => (widget as CubeBuilder<C>);
}

import 'package:cubes/src/actions/navigator_action.dart';
import 'package:flutter/material.dart';

import '../../cubes.dart';

typedef AsyncCubeWidgetBuilder<C extends Cube> = Widget Function(
  BuildContext context,
  C cube,
);

typedef InitCallback<C extends Cube> = Function(C cube);
typedef CubeWidgetDispose<C extends Cube> = bool Function(C cube);

/// Widget responsible for getting instance and providing Cube
class CubeConsumer<C extends Cube> extends StatefulWidget {
  const CubeConsumer({
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
  _CubeConsumerState<C> createState() => _CubeConsumerState<C>();
}

class _CubeConsumerState<C extends Cube> extends State<CubeConsumer>
    with StateMixin {
  late C cube;

  @override
  void initState() {
    cube = cubeWidget.cube ?? inject();
    cube.addOnActionListener(_onAction);
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(_ready);
  }

  @override
  void dispose() {
    if (cubeWidget.dispose?.call(cube) ?? true) {
      cube.dispose();
    }
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
    if (data is NavigationAction) {
      _resolveNavigation(context, data);
    }
    postFrame(() => cubeWidget.onAction?.call(cube, data));
  }

  void _ready(_) {
    cube.onReady(widget.arguments ?? context.arguments);
  }

  CubeConsumer<C> get cubeWidget => (widget as CubeConsumer<C>);

  void _resolveNavigation(BuildContext context, NavigationAction data) {
    switch (data.type) {
      case NavigationType.pushNamed:
        context
            .goToNamed(data.routeName!, arguments: data.arguments)
            .then((r) => data.onResult?.call(r));
        break;
      case NavigationType.pushNamedAndRemoveUntil:
        context
            .goToNamedAndRemoveUntil(
              data.routeName!,
              data.predicate!,
              arguments: data.arguments,
            )
            .then((r) => data.onResult?.call(r));
        break;
      case NavigationType.pushReplacementNamed:
        context
            .goToNamedReplacement(data.routeName!, arguments: data.arguments)
            .then((r) => data.onResult?.call(r));
        break;
      case NavigationType.push:
        context
            .goTo(
              data.builder!,
              settings: data.settings,
              fullscreenDialog: data.fullscreenDialog,
            )
            .then((r) => data.onResult?.call(r));
        break;
      case NavigationType.pushReplacement:
        context
            .goToReplacement(
              data.builder!,
              settings: data.settings,
              fullscreenDialog: data.fullscreenDialog,
            )
            .then((r) => data.onResult?.call(r));
        break;
      case NavigationType.pushAndRemoveUntil:
        context
            .goToAndRemoveUntil(
              data.builder!,
              data.predicate!,
              settings: data.settings,
              fullscreenDialog: data.fullscreenDialog,
            )
            .then((r) => data.onResult?.call(r));
        break;
      case NavigationType.pop:
        context.pop(data.result);
        break;
    }
  }
}

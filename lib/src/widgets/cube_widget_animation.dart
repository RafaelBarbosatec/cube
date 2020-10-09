import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:cubes/src/cube_builder_animation.dart';
import 'package:flutter/widgets.dart';

abstract class CubeWidgetAnimation<C extends Cube> extends StatelessWidget {
  final Map<dynamic, AnimationController> animationControllers = Map();
  final Map<dynamic, Animation> animations = Map();
  void onSuccess(BuildContext context, C cube, String text) {}
  void onError(BuildContext context, C cube, String text) {}
  void onAction(BuildContext context, C cube, dynamic data) {}
  void initState(BuildContext context, C cube, TickerProvider ticker) {}
  void dispose() {}

  dynamic get initData => null;

  @protected
  Widget buildView(BuildContext context, C cube);

  @override
  Widget build(BuildContext context) {
    return CubeBuilderAnimation<C>(
      builder: buildView,
      onError: (cube, text) => onError(context, cube, text),
      onSuccess: (cube, text) => onSuccess(context, cube, text),
      onAction: (cube, data) => onAction(context, cube, data),
      initState: (cube, ticker) => initState(context, cube, ticker),
      initData: initData,
      dispose: () {
        animationControllers.forEach((key, value) => value.dispose());
        animationControllers.clear();
        animations.clear();
        dispose();
      },
    );
  }
}

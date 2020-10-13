import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:cubes/src/cube_builder_animation.dart';
import 'package:flutter/widgets.dart';

abstract class CubeWidgetAnimation<C extends Cube> extends StatelessWidget {
  final Map<dynamic, AnimationController> _animationControllers = Map();
  final Map<dynamic, Animation> _animations = Map();
  void onSuccess(BuildContext context, C cube, String text) {}
  void onError(BuildContext context, C cube, String text) {}
  void onAction(BuildContext context, C cube, dynamic data) {}
  void initState(BuildContext context, C cube, TickerProvider ticker) {}
  void dispose() {}

  dynamic get initData => null;

  AnimationController confAnimationController(
    dynamic id,
    TickerProvider ticker, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    _animationControllers[id] = AnimationController(
      vsync: ticker,
      duration: duration,
    );
    return _animationControllers[id];
  }

  AnimationController getAnimController(dynamic id) =>
      _animationControllers[id];

  Animation setAnimation(dynamic id, Animation animation) {
    _animations[id] = animation;
    return _animations[id];
  }

  Animation getAnimation(dynamic id) => _animations[id];

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
        _animationControllers.forEach((key, value) => value.dispose());
        _animationControllers.clear();
        _animations.clear();
        dispose();
      },
    );
  }
}

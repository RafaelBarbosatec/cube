import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:cubes/src/cube_builder_animation.dart';
import 'package:cubes/src/util/ticker_provider_container.dart';
import 'package:flutter/widgets.dart';

/// (EXPERIMENTAL) CubeWidget created to use animations.
abstract class CubeWidgetAnimation<C extends Cube> extends StatelessWidget {
  final Map<dynamic, AnimationController> _animationControllers = Map();
  final Map<dynamic, Animation> _animations = Map();
  final TickerProviderContainer tickerContainer = TickerProviderContainer();
  void onAction(BuildContext context, C cube, CubeAction data) {}
  void initState(BuildContext context, C cube) {}
  void dispose() {}

  dynamic get initData => null;

  AnimationController confAnimationController(
    dynamic id, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    _animationControllers[id] = AnimationController(
      vsync: tickerContainer.ticker,
      duration: duration,
    );
    return _animationControllers[id];
  }

  AnimationController getAnimController(dynamic id) => _animationControllers[id];

  Animation confAnimation(dynamic id, Animation animation) {
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
      initData: initData,
      onAction: (cube, data) => onAction(context, cube, data),
      initState: (cube, ticker) {
        tickerContainer.ticker = ticker;
        initState(context, cube);
      },
      dispose: () {
        _animationControllers.forEach((key, value) => value.dispose());
        _animationControllers.clear();
        _animations.clear();
        dispose();
      },
    );
  }
}

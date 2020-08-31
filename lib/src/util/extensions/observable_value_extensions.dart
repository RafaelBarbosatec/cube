import 'package:cubes/src/observable_value.dart';
import 'package:cubes/src/observer.dart';
import 'package:flutter/widgets.dart';

extension ObservableValueExtensions on ObservableValue {
  Observer build<T>(
    ObserverBuilder<T> build, {
    bool animate = false,
    AnimatedSwitcherTransitionBuilder transitionBuilder =
        AnimatedSwitcher.defaultTransitionBuilder,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Observer<T>(
      observable: this,
      animate: animate,
      transitionBuilder: transitionBuilder,
      duration: duration,
      builder: build,
    );
  }
}

import 'package:cubes/src/observable/observable_value.dart';
import 'package:cubes/src/widgets/observer.dart';
import 'package:flutter/widgets.dart';

extension ObservableValueExtensions on ObservableValue {
  CObserver build<T>(
    ObserverBuilder<T> build, {
    bool animate = false,
    WhenBuild<T> when,
    AnimatedSwitcherTransitionBuilder transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CObserver<T>(
      observable: this,
      animate: animate,
      transitionBuilder: transitionBuilder,
      duration: duration,
      when: when,
      builder: build,
    );
  }
}

import 'package:cubes/cubes.dart';
import 'package:flutter/widgets.dart';

import '../../observable/observable_value.dart';
import '../../widgets/observer.dart';

/// Extension to facilitate the use of CObserver
extension ObservableValueExtensions on ObservableValue {
  /// Use to create CObserver by ObservableValue
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

/// Extension to facilitate create ObservableValue
extension ObservableExtension<T> on T {
  /// Create ObservableValue<T>
  ObservableValue<T> get obsValue => ObservableValue<T>(value: this);
}

/// Extension to facilitate create ObservableList
extension ListToObservableValue<T> on List<T> {
  /// Create ObservableList<T>
  ObservableList<T> get obsValue => ObservableList<T>(value: this);
}

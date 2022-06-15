import 'package:flutter/widgets.dart';

import '../../../cubes.dart';
import '../../widgets/observer.dart';

/// Extension to facilitate the use of CObserver
extension ObservableValueExtensions on ObservableValue {
  /// Use to create CObserver by ObservableValue
  CObserver<T> build<T>(
    ObserverBuilder<T> build, {
    bool animate = false,
    WhenBuild<T>? when,
    AnimatedSwitcherTransitionBuilder transitionBuilder =
        AnimatedSwitcher.defaultTransitionBuilder,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CObserver<T>(
      observable: this as ObservableValue<T>,
      animate: animate,
      transitionBuilder: transitionBuilder,
      duration: duration,
      when: when,
      builder: build,
    );
  }
}

/// Extension to facilitate create ObservableValue
extension ObservableValueExtension<T> on T {
  /// Create ObservableValue<T>
  ObservableValue<T> get obs => ObservableValue<T>(value: this);
}

/// Extension to facilitate create ObservableList
extension ListToObservableValue<T> on List<T> {
  /// Create ObservableList<T>
  ObservableList<T> get obs => ObservableList<T>(value: this);
}

extension FeedbackControlExtensions<T> on ObservableValue<CFeedBackControl<T>> {
  void show({T? data}) {
    modify((value) => value.copyWith(show: true, data: data));
  }

  void hide() {
    modify((value) => value.copyWith(show: false));
  }
}

extension CTextFormFieldControlExtensions
    on ObservableValue<CTextFormFieldControl> {
  String get text => value.text;
  set text(String text) {
    modify((value) => value.copyWith(text: text));
  }

  String get error => value.error ?? '';
  set error(String? error) {
    modify((value) => value.copyWith(error: error));
  }

  bool get enable => value.enable;
  set enable(bool enable) {
    modify((value) => value.copyWith(enable: enable));
  }

  bool get enableObscureText => value.obscureText;
  set enableObscureText(bool enable) {
    modify((value) => value.copyWith(obscureText: enable));
  }
}

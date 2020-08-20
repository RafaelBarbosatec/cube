import 'package:cubes/src/observable_value.dart';
import 'package:cubes/src/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  Future goTo(Widget widget) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future goToReplacement(Widget widget) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future goToAndRemoveUntil(Widget widget, RoutePredicate predicate) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => widget),
      predicate,
    );
  }

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  EdgeInsets get passing => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  Size get sizeScreen => mediaQuery.size;
  double get widthScreen => sizeScreen.width;
  double get heightScreen => sizeScreen.height;

  ThemeData get theme => Theme.of(this);
  ScaffoldState get scaffold => Scaffold.of(this);
}

extension ObservableValueExtensions on ObservableValue {
  Observer build<T>(
    ObserverBuilder<T> build, {
    bool animate = false,
    AnimatedSwitcherTransitionBuilder transitionBuilder =
        AnimatedSwitcher.defaultTransitionBuilder,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Observer(
      observable: this,
      animate: animate,
      transitionBuilder: transitionBuilder,
      duration: duration,
      builder: (value) => build(value as T),
    );
  }
}

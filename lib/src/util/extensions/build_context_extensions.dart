import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension BuildContextExtensions on BuildContext {
  Future<T> goTo<T extends Object>(Widget widget) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future<T> goToReplacement<T extends Object, TO extends Object>(
      Widget widget) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future<T> goToAndRemoveUntil<T extends Object>(
      Widget widget, RoutePredicate predicate) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => widget),
      predicate,
    );
  }

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  Size get sizeScreen => mediaQuery.size;
  double get widthScreen => sizeScreen.width;
  double get heightScreen => sizeScreen.height;

  ThemeData get theme => Theme.of(this);
  ScaffoldState get scaffold => Scaffold.of(this);
}

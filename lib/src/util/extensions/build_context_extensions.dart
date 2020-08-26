import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  Size get sizeScreen => mediaQuery.size;
  double get widthScreen => sizeScreen.width;
  double get heightScreen => sizeScreen.height;

  ThemeData get theme => Theme.of(this);
  ScaffoldState get scaffold => Scaffold.of(this);
}

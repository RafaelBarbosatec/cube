import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../cubes.dart';
import '../../cube.dart';

extension BuildContextExtensions on BuildContext {
  Future<T?> goTo<T extends Object?>(
    Widget widget, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.push<T?>(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
    );
  }

  Future<T?> goToReplacement<T extends Object?, TO extends Object?>(
    Widget widget, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
    );
  }

  Future<T?> goToAndRemoveUntil<T extends Object?>(
    Widget widget,
    RoutePredicate predicate, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
      predicate,
    );
  }

  void pop<T>([T? result]) {
    Navigator.pop(this, result);
  }

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  Size get sizeScreen => mediaQuery.size;
  double get widthScreen => sizeScreen.width;
  double get heightScreen => sizeScreen.height;

  ThemeData get theme => Theme.of(this);
  ScaffoldState get scaffold => Scaffold.of(this);

  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  C? getCube<C extends Cube>() => Cubes.of<C>(this);

  Object? get arguments => ModalRoute.of(this)?.settings.arguments;
}

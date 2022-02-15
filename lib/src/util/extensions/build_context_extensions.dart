import 'package:flutter/material.dart';

import '../../../cubes.dart';

extension BuildContextExtensions on BuildContext {
  Future<T?> goToNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T?>(this, routeName, arguments: arguments);
  }

  Future<T?> goToNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> goToNamedReplacement<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> goTo<T extends Object?>(
    WidgetBuilder builder, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.push<T?>(
      this,
      MaterialPageRoute(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
    );
  }

  Future<T?> goToReplacement<T extends Object?, TO extends Object?>(
    WidgetBuilder builder, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
    );
  }

  Future<T?> goToAndRemoveUntil<T extends Object?>(
    WidgetBuilder builder,
    RoutePredicate predicate, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(
        builder: builder,
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
  TextTheme get textTheme => theme.textTheme;
  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackBar(SnackBar snackBar) {
    scaffoldMessenger.showSnackBar(snackBar);
  }

  void clearSnackBars() {
    scaffoldMessenger.clearSnackBars();
  }

  C? getCube<C extends Cube>() => Cubes.of<C>(this);

  Object? get arguments => ModalRoute.of(this)?.settings.arguments;
}

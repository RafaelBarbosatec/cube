import 'package:flutter/widgets.dart';

import '../cube.dart';

/// Used to provide `Cube`
class CubeProvider<C extends Cube> extends InheritedWidget {
  final C cube;

  /// CubeProvider constructor
  CubeProvider({
    Key key,
    @required this.cube,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  /// Used to return Cube that was provided
  static C of<C extends Cube>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CubeProvider<C>>().cube;
  }

  @override
  bool updateShouldNotify(covariant CubeProvider oldWidget) =>
      oldWidget.cube != cube;
}

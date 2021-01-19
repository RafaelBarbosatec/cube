import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:flutter/widgets.dart';

abstract class CubeWidget<C extends Cube> extends StatelessWidget {
  /// called when cube send any Action to view.
  void onAction(BuildContext context, C cube, CubeAction data) {}

  /// called when execute initState of the CubeBuilder
  void initState(BuildContext context, C cube) {}

  /// if you want the widget to not call `dispose` in the Cube, return false
  bool dispose(C cube) => true;

  Object get arguments => null;

  @protected
  Widget buildView(BuildContext context, C cube);

  @override
  Widget build(BuildContext context) {
    return CubeBuilder<C>(
      builder: buildView,
      arguments: arguments,
      onAction: (cube, data) => onAction(context, cube, data),
      initState: (cube) => initState(context, cube),
      dispose: dispose,
    );
  }
}

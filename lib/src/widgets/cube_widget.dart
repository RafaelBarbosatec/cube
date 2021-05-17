import 'package:flutter/widgets.dart';

import '../../cubes.dart';
import '../cube.dart';

/// Widget created to replace StatelessWidget and facilitate the use of Cube
/// This is responsible for getting instance and providing Cube
abstract class CubeWidget<C extends Cube> extends StatelessWidget {
  /// called when cube send any Action to view.
  // ignore: no-empty-block
  void onAction(BuildContext context, C cube, CubeAction action) {}

  /// if you want the widget to not call `dispose` in the Cube, return false
  bool dispose(C? cube) => true;

  /// Arguments that will be sent to the cube through the onReady () method
  /// If this argument is not set,
  /// ModalRoute.of(context)?.settings?.Arguments will be sent
  Object? get arguments => null;

  @protected
  Widget buildView(BuildContext context, C cube);

  @override
  Widget build(BuildContext context) {
    return CubeBuilder<C>(
      builder: buildView,
      arguments: arguments,
      onAction: (cube, data) => onAction(context, cube, data),
      dispose: dispose,
    );
  }
}

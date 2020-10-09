import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:flutter/widgets.dart';

abstract class CubeWidget<C extends Cube> extends StatelessWidget {
  void onSuccess(BuildContext context, C cube, String text) {}
  void onError(BuildContext context, C cube, String text) {}
  void onAction(BuildContext context, C cube, dynamic data) {}
  void initState(BuildContext context, C cube) {}
  void dispose() {}

  dynamic get initData => null;

  @protected
  Widget buildView(BuildContext context, C cube);

  @override
  Widget build(BuildContext context) {
    return CubeBuilder<C>(
      builder: buildView,
      onError: (cube, text) => onError(context, cube, text),
      onSuccess: (cube, text) => onSuccess(context, cube, text),
      onAction: (cube, data) => onAction(context, cube, data),
      initState: (cube) => initState(context, cube),
      initData: initData,
      dispose: dispose,
    );
  }
}

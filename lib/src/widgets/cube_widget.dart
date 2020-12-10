import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:flutter/widgets.dart';

abstract class CubeWidget<C extends Cube> extends StatelessWidget {
  void onAction(BuildContext context, C cube, CubeAction data) {}
  void initState(BuildContext context, C cube) {}
  void dispose() {}

  dynamic get initData => null;
  bool get callCubeDispose => true;

  @protected
  Widget buildView(BuildContext context, C cube);

  @override
  Widget build(BuildContext context) {
    return CubeBuilder<C>(
      builder: buildView,
      initData: initData,
      callCubeDispose: callCubeDispose,
      onAction: (cube, data) => onAction(context, cube, data),
      initState: (cube) => initState(context, cube),
      dispose: dispose,
    );
  }
}

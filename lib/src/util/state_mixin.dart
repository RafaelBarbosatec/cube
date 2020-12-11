import 'package:cubes/cubes.dart';
import 'package:cubes/src/cube.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void postFrame(VoidCallback callback) {
    Future.delayed(Duration.zero, () {
      if (mounted) callback();
    });
  }
}

mixin CubeMixin<T extends StatefulWidget, C extends Cube> on State<T> {
  C cube;

  @override
  void initState() {
    cube = cube ?? Cubes.getDependency();
    cube.addOnActionListener(onAction);
    WidgetsBinding.instance.addPostFrameCallback((_) => cube.ready());
    super.initState();
  }

  @override
  void dispose() {
    cube.dispose();
    cube.removeOnActionListener(onAction);
    super.dispose();
  }

  void onAction(C cube, CubeAction action);
}

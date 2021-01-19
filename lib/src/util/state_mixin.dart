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

mixin CubeStateMixin<T extends StatefulWidget, C extends Cube> on State<T> {
  C cube;

  Object get initData => null;

  @override
  void initState() {
    cube = cube ?? Cubes.getDependency();
    cube.addOnActionListener(_innerOnAction);
    WidgetsBinding.instance.addPostFrameCallback(_ready);
    super.initState();
  }

  @override
  void dispose() {
    cube.dispose();
    removeOnActionListener();
    super.dispose();
  }

  void removeOnActionListener() => cube.removeOnActionListener(_innerOnAction);

  void _innerOnAction(C cube, CubeAction action) => onAction(action);

  void onAction(CubeAction action);

  void _ready(_) {
    Object data = initData ?? ModalRoute.of(context)?.settings?.arguments;
    cube.onReady(data);
  }
}

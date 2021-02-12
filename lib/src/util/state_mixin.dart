import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../cubes.dart';
import '../cube.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  /// Used to update widget in next frame
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
    var data = initData ?? ModalRoute.of(context)?.settings?.arguments;
    cube.onReady(data);
  }
}

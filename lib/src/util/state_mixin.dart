import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../cubes.dart';
import '../cube.dart';

/// Mixin postFrame to uses in State
mixin StateMixin<T extends StatefulWidget> on State<T> {
  /// Used to update widget in next frame
  void postFrame(VoidCallback callback) {
    Future.delayed(Duration.zero, () {
      if (mounted) callback();
    });
  }
}

/// Mixin to user Cube in StatefulWidget
mixin CubeStateMixin<T extends StatefulWidget, C extends Cube> on State<T> {
  /// Cube that will be used
  C cube;

  /// Initial data used in `cube.onReady`
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

  /// Remove action listeners.
  void removeOnActionListener() => cube.removeOnActionListener(_innerOnAction);

  void _innerOnAction(C cube, CubeAction action) => onAction(action);

  /// Method tha receive action from cube.
  void onAction(CubeAction action);

  void _ready(_) {
    var data = initData ?? ModalRoute.of(context)?.settings?.arguments;
    cube.onReady(data);
  }
}

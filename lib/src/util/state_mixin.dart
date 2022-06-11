import 'package:flutter/widgets.dart';

import '../../cubes.dart';

/// Mixin postFrame to uses in State
extension StateExt on State {
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
  C? _cube;

  set cube(C cube) => _cube = cube;
  C get cube => _cube!;

  /// Initial data used in `cube.onReady`
  Object? get initData => null;

  @override
  void initState() {
    super.initState();
    _cube = _cube ?? inject();
    _cube?.addOnActionListener(_innerOnAction);
    postFrame(_ready);
  }

  @override
  void dispose() {
    _cube?.dispose();
    removeOnActionListener();
    super.dispose();
  }

  /// Remove action listeners.
  void removeOnActionListener() =>
      _cube?.removeOnActionListener(_innerOnAction);

  void _innerOnAction(C cube, CubeAction action) => onAction(action);

  /// Method tha receive action from cube.
  void onAction(CubeAction action);

  void _ready() {
    var data = initData ?? ModalRoute.of(context)?.settings.arguments;
    _cube?.onReady(data);
  }
}

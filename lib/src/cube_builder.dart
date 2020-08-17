import 'package:cube/src/cube.dart';
import 'package:cube/src/injector.dart';
import 'package:flutter/material.dart';

typedef AsyncWidgetBuilder<C extends Cube> = Widget Function(
  BuildContext context,
  C cube,
);

class CubeBuilder<C extends Cube> extends StatefulWidget {
  final dynamic initData;
  final AsyncWidgetBuilder<C> builder;
  final ValueChanged<String> onSuccess;
  final ValueChanged<String> onError;
  final C cube;
  AsyncWidgetBuilder _builderInner;

  CubeBuilder(
      {Key key,
      @required this.builder,
      this.onSuccess,
      this.onError,
      this.initData,
      this.cube})
      : super(key: key) {
    _confBuilders();
  }

  void _confBuilders() {
    _builderInner = (context, cube) => builder(context, cube);
  }

  @override
  _CubeBuilderState<C> createState() => _CubeBuilderState<C>();
}

class _CubeBuilderState<C extends Cube> extends State<CubeBuilder> {
  C cube;
  @override
  void initState() {
    if (widget.cube == null) {
      cube = getDependency();
    } else {
      cube = widget.cube;
    }
    cube.data = widget.initData;
    cube.addOnSuccessListener(widget.onSuccess);
    cube.addOnErrorListener(widget.onError);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => cube.init());
  }

  @override
  void dispose() {
    cube.removeOnSuccessListener(widget.onSuccess);
    cube.removeOnErrorListener(widget.onError);
    cube.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builderInner(context, cube);
  }
}

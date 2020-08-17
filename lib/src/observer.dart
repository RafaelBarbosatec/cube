import 'package:cubes/src/observable_value.dart';
import 'package:flutter/material.dart';

typedef ObserverBuilder<T> = Widget Function(T value);

class Observer<T> extends StatefulWidget {
  final ObservableValue<T> observable;
  final ObserverBuilder builder;

  const Observer({
    Key key,
    @required this.observable,
    @required this.builder,
  }) : super(key: key);
  @override
  _ObserverState createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
  @override
  void initState() {
    widget.observable?.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.observable?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(widget.observable.value);
  }

  void _listener() {
    setState(() {});
  }
}
